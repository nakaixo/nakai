import gleam/list
import gleam/option
import gleam/string
import gleam/string_builder.{type StringBuilder}
import nakai/attr.{type Attr, Attr}
import nakai/html.{type Node}
import nakai/internal/document.{type Document}

type Builder(output) {
  Builder(map: fn(Node) -> output, fold: fn(List(output)) -> output)
}

const document_builder = Builder(
  map: render_document_node,
  fold: document.concat,
)

const inline_builder = Builder(
  map: render_inline_node,
  fold: string_builder.concat,
)

fn render_doctype(doctype: String) -> StringBuilder {
  string_builder.from_strings(["<!DOCTYPE ", doctype, ">\n"])
}

fn render_children(children: List(Node), builder: Builder(output)) -> output {
  children
  |> list.map(builder.map)
  |> builder.fold()
}

fn render_attrs(attrs: List(Attr)) -> StringBuilder {
  attrs
  |> list.map(render_attr)
  |> list.fold(string_builder.new(), string_builder.append_builder)
}

fn render_attr(attr: Attr) -> StringBuilder {
  let Attr(name, value) = attr
  let sanitized_value =
    value
    |> string.replace("\"", "&quot;")
    |> string.replace(">", "&gt;")
  string_builder.from_strings([" ", name, "=\"", sanitized_value, "\""])
}

fn render_document_node(tree: Node) -> Document {
  case tree {
    html.Doctype(doctype) -> document.from_doctype(doctype)

    html.Html(attrs, children) ->
      render_children(children, document_builder)
      |> document.append_html_attrs(render_attrs(attrs))

    html.Head(children) ->
      render_children(children, document_builder)
      |> document.into_head()

    html.Body(attrs, children) ->
      render_children(children, document_builder)
      |> document.append_body_attrs(render_attrs(attrs))

    html.Fragment(children) -> render_children(children, document_builder)

    html.Element(tag, attrs, children) -> {
      let child_document = render_children(children, document_builder)
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        render_attrs(attrs),
        string_builder.from_string(">"),
        child_document.body,
        string_builder.from_strings(["</", tag, ">"]),
      ])
      |> document.replace_body(child_document, _)
    }

    html.LeafElement(tag, attrs) ->
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        render_attrs(attrs),
        string_builder.from_string(" />"),
      ])
      |> document.from_body()

    html.Comment(content) -> {
      let content =
        content
        |> string.replace("-->", "")
      string_builder.from_strings(["<!-- ", content, " -->"])
      |> document.from_body()
    }

    html.Text(content) ->
      string_builder.from_string(content)
      |> string_builder.replace("&", "&amp;")
      |> string_builder.replace("<", "&lt;")
      |> string_builder.replace(">", "&gt;")
      |> document.from_body()

    html.UnsafeInlineHtml(content) ->
      string_builder.from_string(content)
      |> document.from_body()

    html.Script(script) -> document.from_script(script)

    html.Nothing -> document.new()
  }
}

fn render_inline_node(tree: Node) -> StringBuilder {
  case tree {
    html.Doctype(doctype) -> render_doctype(doctype)

    html.Html(attrs, children) ->
      render_inline_node(html.Element("html", attrs, children))

    html.Head(children) ->
      render_inline_node(html.Element("head", [], children))

    html.Body(attrs, children) ->
      render_inline_node(html.Element("body", attrs, children))

    html.Fragment(children) -> render_children(children, inline_builder)

    html.Element(tag, attrs, children) -> {
      let child_document = render_children(children, inline_builder)
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        render_attrs(attrs),
        string_builder.from_string(">"),
        child_document,
        string_builder.from_strings(["</", tag, ">"]),
      ])
    }

    html.LeafElement(tag, attrs) ->
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        render_attrs(attrs),
        string_builder.from_string(" />"),
      ])

    html.Comment(content) -> {
      let content =
        content
        |> string.replace("-->", "")
      string_builder.from_strings(["<!-- ", content, " -->"])
    }

    html.Text(content) ->
      string_builder.from_string(content)
      |> string_builder.replace("&", "&amp;")
      |> string_builder.replace("<", "&lt;")
      |> string_builder.replace(">", "&gt;")

    html.UnsafeInlineHtml(content) -> string_builder.from_string(content)

    html.Script(script) ->
      render_inline_node(
        html.Element("script", [attr.type_("module")], [html.Text(script)]),
      )

    html.Nothing -> string_builder.new()
  }
}

fn render_script(script: String) -> StringBuilder {
  string_builder.concat([
    string_builder.from_string("<script>"),
    string_builder.from_string(script),
    string_builder.from_string("</script>\n"),
  ])
}

fn render_scripts(scripts: List(String)) -> StringBuilder {
  scripts
  |> list.map(render_script)
  |> string_builder.concat()
}

pub fn render_document(tree: Node) -> StringBuilder {
  let result = render_document_node(tree)
  string_builder.concat([
    render_doctype(
      result.doctype
      |> option.unwrap("html"),
    ),
    string_builder.from_string("<html"),
    result.html_attrs,
    string_builder.from_string(">\n<head>" <> document.encoding),
    result.head,
    string_builder.from_string("</head>\n<body"),
    result.body_attrs,
    string_builder.from_string(">"),
    result.body,
    render_scripts(result.scripts),
    string_builder.from_string("</body>\n</html>\n"),
  ])
}

pub fn render_inline(tree: Node) -> StringBuilder {
  render_inline_node(tree)
}

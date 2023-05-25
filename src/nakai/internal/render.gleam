import gleam/list
import gleam/option
import gleam/string_builder.{StringBuilder}
import gleam/string
import nakai/html.{Node}
import nakai/html/attrs.{Attr, Event}
import nakai/internal/document.{Document}

const document_encoding = "
<meta charset=\"utf-8\" />
<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />
"

fn render_doctype(doctype: String) -> StringBuilder {
  string_builder.from_strings(["<!DOCTYPE ", doctype, ">\n"])
}

fn render_children(children: List(Node(a))) -> Document {
  children
  |> list.map(render_node)
  |> list.fold(document.new(), document.merge)
}

fn render_attrs(attrs: List(Attr(a))) -> StringBuilder {
  attrs
  |> list.map(render_attr)
  |> list.fold(string_builder.new(), string_builder.append_builder)
}

fn render_attr(attr: Attr(a)) -> StringBuilder {
  case attr {
    Attr(name, value) -> {
      let sanitized_value =
        value
        |> string.replace("\"", "&quot;")
        |> string.replace(">", "&gt;")
      string_builder.from_strings([" ", name, "=\"", sanitized_value, "\""])
    }
    Event(_name, _action) -> {
      string_builder.new()
    }
  }
}

fn render_node(tree: Node(a)) -> Document {
  case tree {
    html.Doctype(doctype) -> document.from_doctype(doctype)

    html.Html(attrs, children) ->
      render_children(children)
      |> document.append_html_attrs(render_attrs(attrs))

    html.Head(children) ->
      render_children(children)
      |> document.into_head()

    html.Body(attrs, children) ->
      render_children(children)
      |> document.append_body_attrs(render_attrs(attrs))

    html.Fragment(children) -> render_children(children)

    html.Element(tag, attrs, children) -> {
      let child_document = render_children(children)
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

    html.UnsafeText(content) ->
      string_builder.from_string(content)
      |> document.from_body()

    html.Script(script) -> document.from_script(script)

    html.Nothing -> document.new()
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

pub fn render_root(tree: Node(a)) -> StringBuilder {
  let result = render_node(tree)
  string_builder.concat([
    render_doctype(
      result.doctype
      |> option.unwrap("html"),
    ),
    string_builder.from_string("<html"),
    result.html_attrs,
    string_builder.from_string(">\n<head>" <> document_encoding),
    result.head,
    string_builder.from_string("</head>\n<body"),
    result.body_attrs,
    string_builder.from_string(">"),
    result.body,
    render_scripts(result.scripts),
    string_builder.from_string("</body>\n</html>\n"),
  ])
}

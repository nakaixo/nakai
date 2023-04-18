import gleam/list
import gleam/option
import gleam/string_builder.{StringBuilder}
import gleam/string
import nakai/html.{Node}
import nakai/html/attrs.{Attr, Event}
import nakai/internal/render_state.{State} as state

const document_encoding = "
<meta charset=\"utf-8\" />
<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />
"

pub fn render_doctype(doctype: String) -> StringBuilder {
  string_builder.from_strings(["<!DOCTYPE ", doctype, ">\n"])
}

pub fn render_children(children: List(Node(a))) -> State {
  children
  |> list.map(render_node)
  |> list.fold(state.new(), state.append)
}

pub fn render_attrs(attrs: List(Attr(a))) -> StringBuilder {
  attrs
  |> list.map(render_attr)
  |> list.fold(string_builder.new(), string_builder.append_builder)
}

pub fn render_attr(attr: Attr(a)) -> StringBuilder {
  case attr {
    Attr(name, value) -> {
      let sanitized_value = string.replace(value, "\"", "\\\"")
      string_builder.from_strings([" ", name, "=\"", sanitized_value, "\""])
    }
    Event(_name, _action) -> {
      string_builder.new()
    }
  }
}

pub fn render_node(tree: Node(a)) -> State {
  case tree {
    html.Doctype(doctype) -> state.from_doctype(doctype)

    html.Html(attrs, children) -> {
      render_children(children)
      |> state.append_html_attrs(render_attrs(attrs))
    }

    html.Head(children) ->
      render_children(children)
      |> state.into_head()

    html.Fragment(children) -> render_children(children)

    html.Comment(content) ->
      string_builder.from_strings(["<!-- ", content, " -->"])
      |> state.from_body()

    html.Element(tag, attrs, children) -> {
      let children_state = render_children(children)
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        render_attrs(attrs),
        string_builder.from_string(">"),
        children_state.body,
        string_builder.from_strings(["</", tag, ">"]),
      ])
      |> state.replace_body(children_state, _)
    }

    html.LeafElement(tag, attrs) -> {
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        render_attrs(attrs),
        string_builder.from_string(" />"),
      ])
      |> state.from_body()
    }

    html.Text(content) ->
      string_builder.from_string(content)
      |> string_builder.replace("&", "&amp;")
      |> string_builder.replace("<", "&lt;")
      |> string_builder.replace(">", "&gt;")
      |> state.from_body()

    html.UnsafeText(content) ->
      string_builder.from_string(content)
      |> state.from_body()

    html.Nothing -> state.new()
  }
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
    string_builder.from_string("</head>\n<body>"),
    result.body,
    // TODO: `result.scripts`
    string_builder.from_string("</body>\n</html>\n"),
  ])
  // Would it be nice to include version info, or would that just open people up to
  // targeted injection stuff if there's ever a wildly exploitable bug?
  // string_builder.from_string("</body>\n</html>\n<!-- Nakai v0.5.0 -->\n"),
}

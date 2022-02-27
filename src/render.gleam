import gleam/list
import gleam/string_builder.{StringBuilder}
import html/attrs.{Attr}
import node.{Doctype, Node}

pub fn render(doctype doctype: Doctype, root: Node) -> String {
  string_builder.to_string(string_builder.concat([
    render_doctype(doctype),
    render_node(root),
    string_builder.from_string("\n"),
  ]))
}

pub fn render_attr(attr: Attr) -> StringBuilder {
  string_builder.from_strings([" ", attr.name, "=\"", attr.value, "\""])
}

pub fn render_attrs(attrs: List(Attr)) -> StringBuilder {
  attrs
  |> list.map(render_attr)
  |> string_builder.concat
}

pub fn render_children(children: List(Node)) -> StringBuilder {
  children
  |> list.map(render_node)
  |> string_builder.concat
}

pub fn render_doctype(doctype: Doctype) -> StringBuilder {
  string_builder.from_strings(["<!DOCTYPE ", doctype.decl, ">"])
}

pub fn render_node(tree: Node) -> StringBuilder {
  case tree {
    node.Comment(content) ->
      string_builder.from_strings(["<!-- ", content, " -->"])

    node.Component(factory) -> render_node(factory())

    node.Element(tag, attrs, children) ->
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        render_attrs(attrs),
        string_builder.from_string(">"),
        render_children(children),
        string_builder.from_strings(["</", tag, ">"]),
      ])

    node.Fragment(children) -> render_children(children)

    node.LeafElement(tag, attrs) ->
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        render_attrs(attrs),
        string_builder.from_string(" />"),
      ])

    node.None -> string_builder.new()

    node.Text(content) -> string_builder.from_string(content)
  }
}

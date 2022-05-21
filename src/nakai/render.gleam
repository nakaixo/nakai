import gleam/html
import gleam/html/attrs.{Attr}
import gleam/html/doctype.{Doctype}
import gleam/list
import gleam/string_builder.{StringBuilder}
import nakai/nakai.{Node}

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
    nakai.Component(factory) -> render_node(factory())

    nakai.Fragment(children) -> render_children(children)

    nakai.HtmlNode(html_node) ->
      case html_node {
        html.Comment(content) ->
          string_builder.from_strings(["<!-- ", content, " -->"])
        html.Element(tag, attrs, children) ->
          string_builder.concat([
            string_builder.from_strings(["<", tag]),
            render_attrs(attrs),
            string_builder.from_string(">"),
            render_children(list.map(children, nakai.HtmlNode)),
            string_builder.from_strings(["</", tag, ">"]),
          ])
        html.LeafElement(tag, attrs) ->
          string_builder.concat([
            string_builder.from_strings(["<", tag]),
            render_attrs(attrs),
            string_builder.from_string(" />"),
          ])
        html.Text(content) -> string_builder.from_string(content)
      }

    nakai.None -> string_builder.new()
  }
}

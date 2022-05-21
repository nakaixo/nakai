import gleam/html
import gleam/html/doctype.{Doctype}
import gleam/string_builder
import nakai/nakai.{Component, Fragment, HtmlNode, Node, None}
import nakai/render

pub fn const_component(decl: fn() -> Node) -> Node {
  Component(decl)
}

pub fn component(decl: fn(props_type) -> Node, props: props_type) -> Node {
  Component(fn() { decl(props) })
}

pub fn fragment(children: List(Node)) -> Node {
  Fragment(children)
}

pub fn html(node: html.Node) -> Node {
  HtmlNode(node)
}

pub fn none() -> Node {
  None
}

pub fn render_doc(doctype doctype: Doctype, root: Node) -> String {
  string_builder.to_string(string_builder.concat([
    render.render_doctype(doctype),
    render.render_node(root),
    string_builder.from_string("\n"),
  ]))
}

pub fn render(root: Node) -> String {
  string_builder.to_string(string_builder.concat([render.render_node(root)]))
}

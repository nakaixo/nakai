import gleam/string_builder.{StringBuilder}
import nakai/html.{Component, Fragment, Node, Nothing}
import nakai/html/attrs.{Attr}
import nakai/render

pub fn const_component(func: fn() -> Node(a)) -> Node(a) {
  Component(func)
}

pub fn component(func: fn(props_type) -> Node(a), props: props_type) -> Node(a) {
  Component(fn() { func(props) })
}

pub fn fragment(children: List(Node(a))) -> Node(a) {
  Fragment(children)
}

pub fn nothing() -> Node(a) {
  Nothing
}

pub fn render(root: Node(a)) -> StringBuilder {
  string_builder.concat([
    render.render_doctype("html"),
    string_builder.from_string("\n"),
    render.render_root(root, []),
    string_builder.from_string("\n"),
  ])
}

pub fn render_with_document_attrs(
  root: Node(a),
  attrs: List(Attr(a)),
) -> StringBuilder {
  string_builder.concat([
    render.render_doctype("html"),
    string_builder.from_string("\n"),
    render.render_root(root, attrs),
    string_builder.from_string("\n"),
  ])
}

pub fn render_with_doctype(
  doctype doctype: String,
  root root: Node(a),
) -> StringBuilder {
  string_builder.concat([
    render.render_doctype(doctype),
    string_builder.from_string("\n"),
    render.render_root(root, []),
    string_builder.from_string("\n"),
  ])
}

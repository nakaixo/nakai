import gleam/string_builder.{StringBuilder}
import nakai/html.{Comment, Component, Fragment, Node, Nothing}
import nakai/html/doctype.{Doctype}
import nakai/render
import nakai/render/state.{State}

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

pub fn render(root: Node(a)) -> String {
  string_builder.concat([
    render.render_doctype(html.doctype("html")),
    string_builder.from_string("\n"),
    render.render_root(root),
    string_builder.from_string("\n"),
  ])
  |> string_builder.to_string
}

pub fn render_with_doctype(doctype doctype: Doctype, root: Node(a)) -> String {
  string_builder.concat([
    render.render_doctype(doctype),
    string_builder.from_string("\n"),
    render.render_root(root),
    string_builder.from_string("\n"),
  ])
  |> string_builder.to_string
}

pub fn render_with_banner_comment(
  root: Node(a),
  banner content: String,
) -> String {
  string_builder.concat([
    do_not_use_render_node(Comment(content)),
    string_builder.from_string("\n"),
    render.render_doctype(html.doctype("html")),
    string_builder.from_string("\n"),
    render.render_root(root),
    string_builder.from_string("\n"),
  ])
  |> string_builder.to_string
}

fn do_not_use_render_node(node: Node(a)) -> StringBuilder {
  let State(_, b, _) = render.render_node(node)
  b
}

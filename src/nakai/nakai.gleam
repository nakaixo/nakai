import gleam/html

pub type Node {
  Component(factory: fn() -> Node)
  Fragment(children: List(Node))
  HtmlNode(node: html.Node)
  None
}

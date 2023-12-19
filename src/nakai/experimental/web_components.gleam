import nakai/html.{type Node, Element, LeafElement}
import nakai/html/attrs.{type Attr}

pub fn slot(attrs: List(Attr(a))) -> Node(a) {
  LeafElement(tag: "slot", attrs: attrs)
}

pub fn template(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "template", attrs: attrs, children: children)
}

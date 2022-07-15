import nakai/html/attrs.{Attr}
import nakai/html/doctype.{Doctype}

pub type Node(a) {
  Head(children: List(Node(a)))
  Comment(content: String)
  Element(tag: String, attrs: List(Attr(a)), children: List(Node(a)))
  LeafElement(tag: String, attrs: List(Attr(a)))
  Text(content: String)
  Component(factory: fn() -> Node(a))
  Fragment(children: List(Node(a)))
  Nothing
}

pub fn doctype(decl: String) -> Doctype {
  Doctype(decl)
}

pub fn head(children: List(Node(a))) -> Node(a) {
  Head(children)
}

pub fn space() -> Node(a) {
  Text(" ")
}

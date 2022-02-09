import gleam/io
import html/attrs.{Attr}

pub type Doctype {
  Doctype(decl: String)
}

pub type Node {
  Comment(content: String)
  Element(tag: String, attrs: List(Attr), children: List(Node))
  Fragment(children: List(Node))
  LeafElement(tag: String, attrs: List(Attr))
  None
  Text(content: String)
}

pub fn comment(content: String) -> Node {
  Comment(content)
}

pub fn doctype(decl: String) -> Doctype {
  Doctype(decl)
}

pub fn fragment(children: List(Node)) -> Node {
  Fragment(children)
}

pub fn none() -> Node {
  None
}

pub fn text(content: String) -> Node {
  Text(content)
}

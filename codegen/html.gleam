import nakai/html/attrs.{Attr}

pub type Node(a) {
  Head(children: List(Node(a)))
  Comment(content: String)
  Element(tag: String, attrs: List(Attr(a)), children: List(Node(a)))
  LeafElement(tag: String, attrs: List(Attr(a)))
  Text(content: String)
  UnsafeText(content: String)
  Component(factory: fn() -> Node(a))
  Fragment(children: List(Node(a)))
  Nothing
}

pub fn head(children: List(Node(a))) -> Node(a) {
  Head(children)
}

pub fn space() -> Node(a) {
  Text(" ")
}

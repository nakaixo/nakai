import nakai/html/attrs.{Attr}

pub type Node(a) {
  Doctype(content: String)
  Html(attrs: List(Attr(a)), children: List(Node(a)))
  Head(children: List(Node(a)))
  Comment(content: String)
  Element(tag: String, attrs: List(Attr(a)), children: List(Node(a)))
  LeafElement(tag: String, attrs: List(Attr(a)))
  Text(content: String)
  UnsafeText(content: String)
  Fragment(children: List(Node(a)))
  Nothing
}

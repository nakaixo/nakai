import gleam/html/attrs.{Attr}
import gleam/html/doctype.{Doctype}

pub type Node {
  Comment(content: String)
  Element(tag: String, attrs: List(Attr), children: List(Node))
  LeafElement(tag: String, attrs: List(Attr))
  Text(content: String)
}

pub fn doctype(decl: String) -> Doctype {
  Doctype(decl)
}

pub fn space() -> Node {
  Text(" ")
}

// Shorthand functions for common elements
pub fn a(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "a", attrs: attrs, children: children)
}

pub fn body(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "body", attrs: attrs, children: children)
}

pub fn div(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "div", attrs: attrs, children: children)
}

pub fn head(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "head", attrs: attrs, children: children)
}

pub fn html(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "html", attrs: attrs, children: children)
}

pub fn h1(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h1", attrs: attrs, children: children)
}

pub fn h2(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h2", attrs: attrs, children: children)
}

pub fn h3(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h3", attrs: attrs, children: children)
}

pub fn h4(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h4", attrs: attrs, children: children)
}

pub fn h5(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h5", attrs: attrs, children: children)
}

pub fn h6(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h6", attrs: attrs, children: children)
}

pub fn img(attrs: List(Attr)) -> Node {
  LeafElement(tag: "img", attrs: attrs)
}

pub fn li(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "li", attrs: attrs, children: children)
}

pub fn link(attrs: List(Attr)) -> Node {
  LeafElement(tag: "link", attrs: attrs)
}

pub fn ol(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "ol", attrs: attrs, children: children)
}

pub fn p(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "p", attrs: attrs, children: children)
}

pub fn section(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "section", attrs: attrs, children: children)
}

pub fn title(title: String) -> Node {
  Element(tag: "title", attrs: [], children: [Text(title)])
}

pub fn ul(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "ul", attrs: attrs, children: children)
}

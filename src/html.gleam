import html/attrs.{Attr}
import node.{Node}

pub fn a(attrs: List(Attr), children: List(Node)) -> Node {
  node.Element(tag: "a", attrs: attrs, children: children)
}

pub fn body(attrs: List(Attr), children: List(Node)) -> Node {
  node.Element(tag: "body", attrs: attrs, children: children)
}

pub fn div(attrs: List(Attr), children: List(Node)) -> Node {
  node.Element(tag: "div", attrs: attrs, children: children)
}

pub fn head(attrs: List(Attr), children: List(Node)) -> Node {
  node.Element(tag: "head", attrs: attrs, children: children)
}

pub fn html(attrs: List(Attr), children: List(Node)) -> Node {
  node.Element(tag: "html", attrs: attrs, children: children)
}

pub fn img(attrs: List(Attr)) -> Node {
  node.LeafElement(tag: "img", attrs: attrs)
}

pub fn p(attrs: List(Attr), children: List(Node)) -> Node {
  node.Element(tag: "p", attrs: attrs, children: children)
}

pub fn title(title: String) -> Node {
  node.Element(tag: "title", attrs: [], children: [node.Text(title)])
}

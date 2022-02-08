import gleam/list

pub type Attr {
  Attr(name: String, value: String)
}

pub type Element {
  A(attrs: List(Attr), children: List(Element))
  Body(attrs: List(Attr), children: List(Element))
  Div(attrs: List(Attr), children: List(Element))
  Head(attrs: List(Attr), children: List(Element))
  Html(attrs: List(Attr), children: List(Element))
  Img(attrs: List(Attr))
  P(attrs: List(Attr), children: List(Element))

  Text(content: String)
}

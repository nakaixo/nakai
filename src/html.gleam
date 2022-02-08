import html/element.{Attr, Element}

pub fn a() -> Element {
  element.A(attrs: [], children: [])
}

pub fn body() -> Element {
  element.Body(attrs: [], children: [])
}

pub fn div(attrs: List(Attr), children: List(Element)) -> Element {
  element.Div(attrs: [], children: [])
}

pub fn head() -> Element {
  element.Head(attrs: [], children: [])
}

pub fn html() -> Element {
  element.Html(attrs: [], children: [])
}

pub fn img(attrs: List(Attr)) -> Element {
  element.Img(attrs: attrs)
}

pub fn p(attrs: List(Attr), children: List(Element)) -> Element {
  element.P(attrs: [], children: [])
}

pub fn text(content: String) -> Element {
  element.Text(content)
}

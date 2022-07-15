import gleam/string

pub type Attr(a) {
  Attr(name: String, value: String)
  Event(name: String, action: a)
}

pub fn data(name: String, value: String) -> Attr(a) {
  Attr(name: string.append("data-", name), value: value)
}

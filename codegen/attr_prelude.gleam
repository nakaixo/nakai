pub type Attr {
  Attr(name: String, value: String)
}

pub fn data(name: String, value: String) -> Attr {
  Attr(name: "data-" <> name, value: value)
}

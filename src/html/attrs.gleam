pub type Attr {
  Attr(name: String, value: String)
}

pub fn id(id: String) -> Attr {
  Attr(name: "id", value: id)
}

pub fn src(src: String) -> Attr {
  Attr(name: "src", value: src)
}

pub fn width(width: String) -> Attr {
  Attr(name: "width", value: width)
}

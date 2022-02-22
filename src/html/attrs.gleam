pub type Attr {
  Attr(name: String, value: String)
}

pub fn attr(name: String, value: String) -> Attr {
  Attr(name: name, value: value)
}

// Shorthand functions for common attributes
pub fn class(value: String) -> Attr {
  Attr(name: "class", value: value)
}

pub fn height(value: String) -> Attr {
  Attr(name: "height", value: value)
}

pub fn id(id: String) -> Attr {
  Attr(name: "id", value: id)
}

pub fn focus() -> Attr {
  Attr(name: "focus", value: "true")
}

pub fn src(src: String) -> Attr {
  Attr(name: "src", value: src)
}

pub fn width(width: String) -> Attr {
  Attr(name: "width", value: width)
}

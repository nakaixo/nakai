import gleam/string

pub type Attr(a) {
  Attr(name: String, value: String)
  Event(name: String, action: a)
}

pub fn attr(name: String, value: String) -> Attr(a) {
  Attr(name: name, value: value)
}

// TODO: This should probably take `value: Bool = true` once Gleam has defaulted arguments
pub fn autofocus() -> Attr(a) {
  Attr(name: "focus", value: "true")
}

// Shorthand functions for common attributes
pub fn class(value: String) -> Attr(a) {
  Attr(name: "class", value: value)
}

pub fn content(value: String) -> Attr(a) {
  Attr(name: "content", value: value)
}

pub fn data(name: String, value: String) -> Attr(a) {
  Attr(name: string.append("data-", name), value: value)
}

pub fn height(value: String) -> Attr(a) {
  Attr(name: "height", value: value)
}

pub fn href(value: String) -> Attr(a) {
  Attr(name: "href", value: value)
}

pub fn id(value: String) -> Attr(a) {
  Attr(name: "id", value: value)
}

pub fn name(value: String) -> Attr(a) {
  Attr(name: "name", value: value)
}

pub fn rel(value: String) -> Attr(a) {
  Attr(name: "rel", value: value)
}

pub fn src(value: String) -> Attr(a) {
  Attr(name: "src", value: value)
}

pub fn style(value: String) -> Attr(a) {
  Attr(name: "style", value: value)
}

pub fn width(value: String) -> Attr(a) {
  Attr(name: "width", value: value)
}

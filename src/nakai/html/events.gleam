import nakai/html/attrs.{Attr, Event}

pub fn on_click(action: a) -> Attr(a) {
  Event("click", action)
}

import nakai/html
import nakai/html/attrs

pub fn stylesheet(href url: String) {
  html.head([html.link([attrs.rel("stylesheet"), attrs.href(url)])])
}

pub fn title(title: String) {
  html.head([html.title([], [html.Text(title)])])
}

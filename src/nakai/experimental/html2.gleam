import nakai/html
import nakai/html/attrs

pub fn element(tag: String) -> html.Node(a) {
  html.Element(tag, [], [])
}

pub fn attr(node: html.Node(a), attr: String, value: String) -> html.Node(a) {
  case node {
    html.Element(tag, battrs, children) ->
      html.Element(tag, [attrs.Attr(attr, value), ..battrs], children)
    _ -> node
  }
}

pub fn child(node: html.Node(a), child: html.Node(a)) -> html.Node(a) {
  case node {
    html.Element(tag, battrs, children) ->
      html.Element(tag, battrs, [child, ..children])
    _ -> node
  }
}

pub fn text(node: html.Node(a), text: String) -> html.Node(a) {
  node
  |> child(html.Text(text))
}

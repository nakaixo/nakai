import nakai
import nakai/head
import nakai/html
import nakai/html/attrs
import snapshot

pub fn hi_friend_test() {
  html.div([attrs.id("hi")], [html.Text("Hi friend!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/hi_friend.html")
}

pub fn attr_test() {
  html.div([], [html.Text("Hi friend!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/attr.html")
}

pub fn head_test() {
  html.Head([head.title("Hi!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/head.html")
}

pub fn head_nested_test() {
  html.div([], [head.title("Hi!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/head_nested.html")
}

pub fn html_attrs_test() {
  html.Html([attrs.lang("en-US")], [html.p_text([], "Hello!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/html_attrs.html")
}

pub fn doctype_test() {
  html.Fragment([html.Doctype("custom"), html.div_text([], "Hi friend!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/doctype.html")
}

pub fn sanitization_test() {
  html.div_text([], "<script>alert('pwned');</script>")
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/sanitization.html")
}

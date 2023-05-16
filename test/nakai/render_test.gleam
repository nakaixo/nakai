import nakai
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
  html.Head([html.title("Hi!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/head.html")
}

pub fn head_nested_test() {
  html.div([], [html.Head([html.title("Hi!")])])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/head_nested.html")
}

pub fn html_attrs_test() {
  html.Html([attrs.lang("en-US")], [html.p_text([], "Hello!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/html_attrs.html")
}

pub fn body_attrs_test() {
  html.Body([attrs.class("dark-mode")], [html.p_text([], "Hello!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/body_attrs.html")
}

const xhtml11 = "html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\""

pub fn doctype_test() {
  html.Fragment([html.Doctype(xhtml11), html.div_text([], "Hi friend!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/doctype.html")
}

pub fn sanitization_test() {
  html.div_text([], "<script>alert('pwned');</script>")
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/sanitization.html")
}

pub fn attributes_that_are_gleam_keywords_test() {
  html.input([attrs.type_("text")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/attributes_that_are_gleam_keywords.html")
}

pub fn attributes_with_hyphens_test() {
  html.Head([
    html.meta([
      attrs.http_equiv("content-security-policy"),
      attrs.content("default-src 'self';"),
    ]),
  ])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/attributes_with_hyphens.html")
}

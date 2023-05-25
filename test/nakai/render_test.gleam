import nakai
import nakai/experimental/on
import nakai/html
import nakai/html/attrs
import snapshot

pub fn empty_test() {
  html.Nothing
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/empty.html")
}

pub fn hi_friend_test() {
  html.div([attrs.id("hi")], [html.Text("Hi friend!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/hi_friend.html")
}

pub fn head_test() {
  html.Head([html.title("Hi!")])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/head_1.html")

  html.div([], [html.Head([html.title("Hi!")])])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/head_2.html")

  html.Head([html.Head([html.Head([html.title("Hi!")])])])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/head_3.html")
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

pub fn text_sanitization_test() {
  html.div_text([], "<script>alert('pwned');</script>")
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/text_sanitization.html")
}

pub fn attr_sanitization_test() {
  html.div([attrs.id("\"><script>alert('pwned');</script>")], [])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/attr_sanitization_1.html")

  html.div([on.click("\"><script>alert('pwned');</script>")], [])
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/attr_sanitization_2.html")
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

pub fn scripts_test() {
  html.Script("alert('hello!')")
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/scripts.html")
}

pub fn comment_sanitization_test() {
  html.Comment("--><script>alert('pwned');</script>")
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/comment_sanitization.html")
}

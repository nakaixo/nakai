import nakai
import nakai/html
import nakai/html/attrs
import snapshot

pub fn navigation() {
  html.nav([], [
    html.ul([], [
      html.li([], [html.a_text([attrs.href("/home")], "home")]),
      html.li([], [html.a_text([attrs.href("/about")], "about")]),
    ]),
  ])
}

pub fn app() {
  html.div([], [
    html.Html([attrs.lang("en-US")], [navigation()]),
    html.Head([html.title("hello, computer!")]),
    html.Body([attrs.class("post")], []),
    html.h1_text([], "hello, computer!"),
    html.p_text([], "this is a paragraph"),
  ])
}

pub fn app_test() {
  app()
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/integration/info.html")
}

import snapshot
// BEGIN README SNIPPET

import nakai
import nakai/html.{Node}
import nakai/html/attrs.{Attr}

const header_style = "
  color: #331f26;
  font-family: 'Neuton', serif;
  font-size: 128px;
  font-weight: 400;
"

pub fn header(attrs: List(Attr(a)), text: String) -> Node(a) {
  let attrs = [attrs.style(header_style), ..attrs]
  html.h1_text(attrs, text)
}

pub fn app() -> String {
  html.div(
    [],
    [html.Head([html.title("Hello!")]), header([], "Hello, from Nakai!")],
  )
  |> nakai.to_string()
}

// END README SNIPPET

pub fn readme_test() {
  app()
  |> snapshot.match_string("./test/testdata/readme.html")
}

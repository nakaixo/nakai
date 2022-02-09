import gleam/io
import gleam/bit_builder
import gleam/http
import gleam/http/elli
import gleam/map
import html
import html/attrs
import node.{Node}
import render.{render}

pub fn my_service(_req) {
  let body =
    bit_builder.from_string(render(node.doctype("html"), create_test_page()))

  io.println("Doing the thing! Oh yeah!")

  http.response(200)
  |> http.set_resp_body(body)
}

pub fn start() {
  elli.start(my_service, on_port: 3000)
}

fn create_test_page() -> Node {
  html.html(
    [],
    [
      html.head([], [html.title("Hello, sailor!")]),
      html.body(
        [],
        [
          html.div(
            [attrs.id("hi")],
            [
              node.comment("Hayleigh is my bff"),
              html.p([], [node.text("Hey friend!")]),
              node.none(),
              html.img([
                attrs.src("http://www.google.com/intl/en_ALL/images/logo.gif"),
              ]),
            ],
          ),
        ],
      ),
    ],
  )
}

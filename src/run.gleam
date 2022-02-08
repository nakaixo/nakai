import gleam/io
import gleam/bit_builder
import gleam/http
import gleam/http/elli
import gleam/map
import html
import html/element.{Attr, Element}

pub fn my_service(_req) {
  let body = bit_builder.from_string("Hello, world!")

  io.println("Doing the thing! Oh yeah!")

  http.response(200)
  |> http.set_resp_body(body)
}

fn create_test_page() -> Element {
  html.div(
    [],
    [
      html.p([], [html.text("Hello, friend!")]),
      html.img([
        Attr("src", "http://www.google.com/intl/en_ALL/images/logo.gif"),
      ]),
    ],
  )
}

pub fn start() {
  elli.start(my_service, on_port: 3000)
}

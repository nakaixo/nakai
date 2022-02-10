import gleam/bit_builder
import gleam/http
import gleam/http/elli
import gleam/io
import gleam/map
import example
import html
import html/attrs
import node
import render.{render}

pub fn test_service(_req) {
  io.println("nakai: 200 OK /")

  let body =
    render(node.doctype("html"), node.const_component(example.page))
    |> bit_builder.from_string

  http.response(200)
  |> http.set_resp_body(body)
}

pub fn start() {
  elli.start(test_service, on_port: 3000)
}

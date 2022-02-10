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

  node.const_component(example.page)
  |> render(doctype: node.doctype("html"))
  |> bit_builder.from_string
  |> ok
}

fn ok(body: a) -> http.Response(a) {
  http.set_resp_body(http.response(200), body)
}

pub fn start() {
  elli.start(test_service, on_port: 3000)
}

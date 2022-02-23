import gleam/bit_builder
import gleam/http
import gleam/http/elli
import gleam/http/request.{Request}
import gleam/http/response.{Response}
import gleam/io
import gleam/map
import example
import html
import html/attrs
import node
import render.{render}

pub fn test_service(_req: Request(t)) {
  io.println("nakai: 200 OK /")

  node.const_component(example.page)
  |> render(doctype: node.doctype("html"))
  |> bit_builder.from_string
  |> ok
}

fn ok(body: a) -> Response(a) {
  response.new(200)
  |> response.set_body(body)
}

pub fn start() {
  elli.start(test_service, on_port: 3000)
}

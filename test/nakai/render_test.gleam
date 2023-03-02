import gleam/erlang/file
import gleam/erlang/os
import gleam/list
import gleeunit/should
import nakai
import nakai/head
import nakai/html
import nakai/html/attrs
import nakai/html/events

pub fn snapshot(result: String, snapshot_file: String) {
  case os.get_env("SNAPSHOT") {
    // Check against existing snapshots!
    Error(Nil) | Ok("0") | Ok("false") ->
      should.equal(Ok(result), file.read(snapshot_file))
    // Update all of the result snapshots
    _ -> {
      let _ = file.write(result, snapshot_file)
      Nil
    }
  }
}

pub fn hi_friend_test() {
  html.div([attrs.id("hi")], [html.Text("Hi friend!")])
  |> nakai.render
  |> snapshot("./test/testdata/hi_friend.html")
}

pub fn attr_test() {
  html.div([], [html.Text("Hi friend!")])
  |> nakai.render
  |> snapshot("./test/testdata/attr.html")
}

type Action {
  DoThing
}

pub fn event_test() {
  html.div([events.on_click(DoThing)], [html.Text("Hi friend!")])
  |> nakai.render
  |> snapshot("./test/testdata/event.html")
}

pub fn head_test() {
  html.div([], [head.title("Hi!")])
  |> nakai.render
  |> snapshot("./test/testdata/head.html")
}

pub fn html_attrs_test() {
  html.p_text([], "Hello!")
  |> nakai.render_with_document_attrs([attrs.lang("en-US")])
  |> snapshot("./test/testdata/html_attrs.html")
}

pub fn hi_friend_doc_test() {
  html.div([], [html.Text("Hi friend!")])
  |> nakai.render_with_doctype(doctype: html.doctype("custom"))
  |> snapshot("./test/testdata/hi_friend_doc.html")
}

type Puppy {
  Puppy(name: String, good: Bool, soft: Bool)
}

const puppies = [
  Puppy("Dot", good: True, soft: True),
  Puppy("Mady", good: True, soft: True),
]

fn puppy_description(puppy: Puppy) {
  html.li([], [html.Text(puppy.name), html.Text(" is a good and soft puppy")])
}

pub fn puppies_test() {
  html.ul([], list.map(puppies, puppy_description))
  |> nakai.render
  |> snapshot("./test/testdata/puppies.html")
}

pub fn sanitization_test() {
  html.div_text([], "<script>alert('pwned');</script>")
  |> nakai.render
  |> snapshot("./test/testdata/sanitization.html")
}

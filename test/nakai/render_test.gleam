import gleam/list
import gleam/string
import gleeunit/should
import nakai
import nakai/head
import nakai/html
import nakai/html/attrs
import nakai/html/events

pub fn equal_doc(result: String, correct: String) {
  string.concat([
    "<!DOCTYPE html>\n<html>\n<head></head>\n<body>",
    correct,
    "</body>\n</html>\n",
  ])
  |> should.equal(result, _)
}

pub fn hi_friend_test() {
  html.div([attrs.id("hi")], [html.Text("Hi friend!")])
  |> nakai.render
  |> equal_doc("<div id=\"hi\">Hi friend!</div>")
}

pub fn attr_test() {
  html.div([], [html.Text("Hi friend!")])
  |> nakai.render
  |> equal_doc("<div>Hi friend!</div>")
}

type Action {
  DoThing
}

pub fn event_test() {
  html.div([events.on_click(DoThing)], [html.Text("Hi friend!")])
  |> nakai.render
  |> equal_doc(
    "<div data-nakai-ref-click=\"test-ref\">Hi friend!</div><script>\nwindow.addEventListener(\"DOMContentLoaded\", function() {\n          document.querySelector('[data-nakai-ref-click=\"test-ref\"]')\n          .addEventListener('click', () => console.log(\"doing the thing!!!\"));\n          });\n\n</script>",
  )
}

pub fn head_test() {
  html.div([], [head.title("Hi!")])
  |> nakai.render
  |> should.equal(
    "<!DOCTYPE html>\n<html>\n<head><title>Hi!</title></head>\n<body><div></div></body>\n</html>\n",
  )
}

pub fn html_attrs_test() {
  html.p_text([], "Hello!")
  |> nakai.render_with_document_attrs([attrs.lang("en-US")])
  |> should.equal(
    "<!DOCTYPE html>\n<html lang=\"en-US\">\n<head></head>\n<body><p>Hello!</p></body>\n</html>\n",
  )
}

pub fn hi_friend_doc_test() {
  html.div([], [html.Text("Hi friend!")])
  |> nakai.render_with_doctype(doctype: html.doctype("custom"))
  |> should.equal(
    "<!DOCTYPE custom>\n<html>\n<head></head>\n<body><div>Hi friend!</div></body>\n</html>\n",
  )
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
  |> equal_doc(
    "<ul><li>Dot is a good and soft puppy</li><li>Mady is a good and soft puppy</li></ul>",
  )
}

pub fn sanitization_test() {
  html.div_text([], "<script>alert('pwned');</script>")
  |> nakai.render
  |> equal_doc("<div>&lt;script&gt;alert('pwned');&lt;/script&gt;</div>")
}

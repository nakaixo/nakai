import gleam/html
import gleam/list
import gleeunit
import gleeunit/should
import nakai

pub fn main() {
  gleeunit.main()
}

pub fn hi_friend_test() {
  html.div([], [html.Text("Hi friend!")])
  |> nakai.html
  |> nakai.render
  |> should.equal("<div>Hi friend!</div>")
}

pub fn hi_friend_doc_test() {
  html.div([], [html.Text("Hi friend!")])
  |> nakai.html
  |> nakai.render_doc(doctype: html.doctype("html"))
  |> should.equal("<!DOCTYPE html><div>Hi friend!</div>\n")
}

type Puppy {
  Puppy(name: String, good: Bool, soft: Bool)
}

const puppies = [
  Puppy("Dot", good: True, soft: True),
  Puppy("Mady", good: True, soft: True),
]

fn puppy_description(puppy: Puppy) {
  html.li([], [html.Text(puppy.name)])
}

pub fn puppies_test() {
  html.ul([], list.map(puppies, puppy_description))
  |> nakai.html
  |> nakai.render
  |> should.equal("<ul><li>Dot</li><li>Mady</li></ul>")
}

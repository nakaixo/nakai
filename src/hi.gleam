import gleam/html
import nakai

pub fn hi_friend() {
  html.div([], [html.Text("Hi friend! from Gleam!")])
  |> nakai.html
  |> nakai.render_doc(doctype: html.doctype("html"))
}

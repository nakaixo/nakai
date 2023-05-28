import gleeunit/should
import nakai
import nakai/experimental/html2

pub fn basic_test() {
  {
    html2.element("div")
    |> html2.attr("id", "x")
    |> html2.child(
      html2.element("h1")
      |> html2.text("hello, computer!"),
    )
    |> html2.child(
      html2.element("p")
      |> html2.text("there's a radio attached to my head"),
    )
  }
  |> nakai.to_inline_string()
  |> should.equal(
    "<div id=\"x\"><p>there's a radio attached to my head</p><h1>hello, computer!</h1></div>",
  )
}

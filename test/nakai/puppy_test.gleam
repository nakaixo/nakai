import gleam/list
import nakai
import nakai/html
import nakai/html/attrs
import snapshot

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

pub fn puppies_list() {
  html.ul([], list.map(puppies, puppy_description))
}

pub fn puppies_test() {
  html.Html(
    [attrs.lang("en-US")],
    [
      html.Head([html.title_text([], "List of puppies!")]),
      html.div([], [puppies_list()]),
    ],
  )
  |> nakai.to_string_builder()
  |> snapshot.match("./test/testdata/puppies.html")
}

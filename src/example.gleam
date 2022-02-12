import html
import html/attrs
import node.{Node}

const page_title = "Hi friend!"

pub fn page() -> Node {
  html.html(
    [],
    [
      html.head([], [html.title(page_title)]),
      html.body([], [node.component(app, AppProps(title: page_title))]),
    ],
  )
}

pub type AppProps {
  AppProps(title: String)
}

pub fn app(props: AppProps) -> Node {
  let title = props.title
  html.div(
    [attrs.id("hi")],
    [
      html.h1([], [node.text(title)]),
      node.comment("Comments are fun!"),
      html.p(
        [],
        [node.text("This page is generated dynamically by the server!")],
      ),
      node.none(),
      html.img([
        attrs.width("600"),
        attrs.src(
          "https://cdn.mckayla.art/photography/public/21.4.11/24KbSezrV5BUtSQwi-ygI.jpg",
        ),
      ]),
    ],
  )
}

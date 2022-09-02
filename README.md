![Nakai](https://cdn.mckayla.cloud/-/bc0c2f543cd4411f93d9ea7712aafb74/BANNER.webp)

[![Documentation](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/nakai/)

## Getting started

```sh
gleam add nakai
```

```gleam
import gleam/list
import nakai
import nakai/head
import nakai/html.{Node}
import nakai/html/attrs.{Attr}

const header_style = "
  color: #331f26;
  font-family: 'Neuton', serif;
  font-size: 128px;
  font-weight: 400;
"

pub fn header(attrs: List(Attr(a)), text: String) -> Node(a) {
  let attrs =
    [attrs.style(header_style)]
    |> list.append(attrs)

  html.h1_text(attrs, text)
}

pub fn app() -> String {
  html.div([], [
    head.title("Hello!"),
    header([], "Hello, from Nakai!"),
  ])
  |> nakai.render
}
```

## Development

To build Nakai from source, just run `make`

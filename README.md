![Nakai](https://cdn.mckayla.cloud/-/2d8051c1ce2f4fbd91eaf07df5661e25/Nakai-Banner.svg)

[![Documentation](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/nakai/)

## Getting started

```sh
gleam add nakai
```

```gleam
import nakai
import nakai/html.{type Node}
import nakai/attr.{type Attr}

const header_style = "
  color: #331f26;
  font-family: 'Neuton', serif;
  font-size: 128px;
  font-weight: 400;
"

pub fn header(attrs: List(Attr), text: String) -> Node {
  let attrs = [attr.style(header_style), ..attrs]
  html.h1_text(attrs, text)
}

pub fn app() -> String {
  html.div([],
    [
      html.Head([html.title("Hello!")]),
      header([], "Hello, from Nakai!")
    ]
  )
  |> nakai.to_string()
}
```

## Development

While Nakai itself is pure Gleam, and has no dependencies, the benchmarks require having [Elixir] installed, and building it requires that you have [Rebar3] installed.

[elixir]: https://elixir-lang.org/
[rebar3]: https://rebar3.org/

import gleam/dynamic.{Dynamic}
import gleam/erlang/file
import gleam/json
import gleam/list
import gleam/result
import gleam/string

const html_prefix = "





// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * THIS FILE IS GENERATED. DO NOT EDIT IT.                                             *
// * You're probably looking for ./codegen/html_prelude.gleam, or ./codegen/html.json.   *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *





"

type ElementDescription {
  Element(name: String, leaf: Bool)
}

fn element_decoder(
  value: Dynamic,
) -> Result(ElementDescription, dynamic.DecodeErrors) {
  dynamic.decode2(
    Element,
    dynamic.field("name", of: dynamic.string),
    dynamic.field("leaf", of: dynamic.bool),
  )(value)
}

fn codegen_element(element: ElementDescription) -> String {
  case element {
    Element(name, leaf) if leaf == False ->
      "
/// The HTML [`<" <> name <> ">`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/" <> name <> ") element
pub fn " <> name <> "(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: \"" <> name <> "\", attrs: attrs, children: children)
}

/// Shorthand for `html." <> name <> "(attrs, children: [html.Text(text)])`
pub fn " <> name <> "_text(attrs: List(Attr(a)), text: String) -> Node(a) {
  Element(tag: \"" <> name <> "\", attrs: attrs, children: [Text(text)])
}
"
    Element(name, leaf) if leaf == True ->
      "
/// The HTML [`<" <> name <> " />`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/" <> name <> ") element
pub fn " <> name <> "(attrs: List(Attr(a))) -> Node(a) {
  LeafElement(tag: \"" <> name <> "\", attrs: attrs)
}
"
    _ -> panic
  }
}

fn generate_nakai_html() {
  use html_json <- result.then(
    file.read("./codegen/html.json")
    |> result.nil_error(),
  )
  use html <- result.then(
    json.decode(from: html_json, using: dynamic.list(element_decoder))
    |> result.nil_error(),
  )

  use html_prelude <- result.then(
    file.read("./codegen/html_prelude.gleam")
    |> result.nil_error(),
  )

  // Generate code from the defined attributes
  let code =
    html
    |> list.map(codegen_element)
    |> string.concat()

  use _ <- // Produce nakai/html
  result.then(
    file.write(
      string.concat([html_prefix, html_prelude, code]),
      "./src/nakai/html.gleam",
    )
    |> result.nil_error(),
  )

  Ok(Nil)
}

const attrs_prefix = "





// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * THIS FILE IS GENERATED. DO NOT EDIT IT.                                             *
// * You're probably looking for ./codegen/attrs_prelude.gleam, or ./codegen/attrs.json. *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *





"

type AttrDescription {
  Attr(name: String)
  ConstAttr(name: String, value: String)
}

fn attr_decoder(value: Dynamic) -> Result(AttrDescription, dynamic.DecodeErrors) {
  let attr_decoder =
    dynamic.decode1(Attr, dynamic.field("name", of: dynamic.string))
  let constattr_decoder =
    dynamic.decode2(
      ConstAttr,
      dynamic.field("name", of: dynamic.string),
      dynamic.field("value", of: dynamic.string),
    )

  constattr_decoder(value)
  |> result.lazy_or(fn() { attr_decoder(value) })
}

fn codegen_attr(attr: AttrDescription) -> String {
  let name = case attr.name {
    "type" -> "type_"
    name ->
      name
      |> string.replace("-", "_")
  }

  case attr {
    Attr(_) ->
      "
pub fn " <> name <> "(value: String) -> Attr(a) {
  Attr(name: \"" <> name <> "\", value: value)
}
"
    ConstAttr(_, value) ->
      "
pub fn " <> name <> "() -> Attr(a) {
  Attr(name: \"" <> name <> "\", value: \"" <> value <> "\")
}
"
  }
}

fn generate_nakai_html_attrs() {
  use attrs_json <- result.then(
    file.read("./codegen/attrs.json")
    |> result.nil_error(),
  )
  use attrs <- result.then(
    json.decode(from: attrs_json, using: dynamic.list(attr_decoder))
    |> result.nil_error(),
  )

  use attrs_prelude <- result.then(
    file.read("./codegen/attrs_prelude.gleam")
    |> result.nil_error(),
  )

  // Generate code from the defined attributes
  let code =
    attrs
    |> list.map(codegen_attr)
    |> string.concat()

  use _ <- result.then(
    file.write(
      string.concat([attrs_prefix, attrs_prelude, code]),
      "./src/nakai/html/attrs.gleam",
    )
    |> result.nil_error(),
  )

  Ok(Nil)
}

pub fn main() {
  use _ <- result.then(generate_nakai_html())
  use _ <- result.then(generate_nakai_html_attrs())
  Ok(Nil)
}

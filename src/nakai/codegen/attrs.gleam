import gleam/io
import gleam/string
import gleam/erlang/file
import gleam/result
import gleam/list

type AttrDef {
  AttrDef(name: String)
  ConstAttrDef(name: String, value: String)
  AttrDefB(func: String, name: String)
}

const attrs = [
  AttrDef("accept"),
  AttrDef("accept-charset"),
  AttrDef("action"),
  AttrDef("alt"),
  ConstAttrDef("async", "true"),
  AttrDef("autocapitalize"),
  AttrDef("autocomplete"),
  ConstAttrDef("autofocus", "true"),
  ConstAttrDef("autoplay", "true"),
  AttrDef("capture"),
  AttrDef("charset"),
  ConstAttrDef("checked", "true"),
  AttrDef("cite"),
  AttrDef("class"),
  AttrDef("content"),
  ConstAttrDef("contenteditable", "true"),
  ConstAttrDef("crossorigin", "true"),
  ConstAttrDef("defer", "true"),
  ConstAttrDef("disabled", "true"),
  ConstAttrDef("draggable", "true"),
  AttrDef("for"),
  AttrDef("formaction"),
  AttrDef("height"),
  AttrDef("href"),
  AttrDef("http-equiv"),
  AttrDef("id"),
  AttrDef("integrity"),
  AttrDef("lang"),
  ConstAttrDef("loop", "true"),
  AttrDef("name"),
  ConstAttrDef("preload", "true"),
  AttrDef("property"),
  ConstAttrDef("readonly", "true"),
  AttrDef("rel"),
  ConstAttrDef("selected", "true"),
  AttrDef("src"),
  AttrDef("style"),
  AttrDef("tabindex"),
  AttrDef("target"),
  AttrDef("title"),
  AttrDefB("type_", "type"),
  AttrDef("value"),
  AttrDef("width"),
]

// docs: https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/id

fn make_attr_source(def: AttrDef) -> String {
  case def {
    AttrDef(name) -> {
      "
pub fn " <> name <> "(value: String) -> Attr(a) {
  Attr(name: \"${name}\", value: value)
}
"
    }
    ConstAttrDef(name, value) ->
      "
pub fn " <> name <> "() -> Attr(a) {
  Attr(name: \"" <> name <> "\", value: \"" <> value <> "\")
}
"
    AttrDefB(func, name) ->
      "
pub fn " <> func <> "(value: String) -> Attr(a) {
  Attr(name: \"" <> name <> "\", value: value)
}
"
  }
}

// const base = await fetch(new URL("./attrs.gleam", import.meta.url)).then(
// 	(response) => response.text(),
// );
// const attrList = await fetch(new URL("./attrs.json", import.meta.url))
// 	.then((response) => response.json())
// 	.then((list: AttrDef[]) => list.sort((a, b) => a.name.localeCompare(b.name)));

const prefix = "





// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * THIS FILE IS GENERATED. DO NOT EDIT IT.                                             *
// * You're probably looking for ./codegen/attrs.gleam, or ./codegen/attrs.json.         *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *





"

pub fn main() {
  io.println("hello, sailor!")

  attrs
  |> list.map(make_attr_source)
  |> string.concat()
  |> io.println()

  // Deno.writeFile(
  //   new URL("../src/nakai/html/attrs.gleam", import.meta.url).pathname,
  //   te.encode(output),
  // );

  // Format input file
  // Deno.writeFile(
  // 	new URL("./attrs.json", import.meta.url).pathname,
  // 	te.encode(JSON.stringify(attrList, null, 2)),
  // );

  Ok(Nil)
}

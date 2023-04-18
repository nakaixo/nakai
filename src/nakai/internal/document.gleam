import gleam/io
import gleam/option.{Option}
import gleam/list
import gleam/string
import gleam/string_builder.{StringBuilder}

pub type Document {
  Document(
    doctype: Option(String),
    html_attrs: StringBuilder,
    head: StringBuilder,
    body: StringBuilder,
    scripts: List(StringBuilder),
  )
}

pub fn new() {
  Document(
    doctype: option.None,
    html_attrs: string_builder.new(),
    head: string_builder.new(),
    body: string_builder.new(),
    scripts: [],
  )
}

pub fn merge(self: Document, new: Document) -> Document {
  Document(
    // Overwrite the doctype with a newer one, unless the newer one is `None`
    doctype: option.or(new.doctype, self.doctype),
    html_attrs: string_builder.append_builder(self.html_attrs, new.html_attrs),
    head: string_builder.append_builder(self.head, new.head),
    body: string_builder.append_builder(self.body, new.body),
    scripts: list.append(self.scripts, new.scripts),
  )
}

pub fn from_doctype(doctype: String) -> Document {
  Document(..new(), doctype: option.Some(doctype))
}

pub fn append_html_attrs(self: Document, html_attrs: StringBuilder) -> Document {
  Document(
    ..self,
    html_attrs: string_builder.append_builder(self.html_attrs, html_attrs),
  )
}

pub fn from_head(head: StringBuilder) -> Document {
  Document(..new(), head: head)
}

pub fn append_head(self: Document, head: StringBuilder) -> Document {
  Document(..self, head: string_builder.append_builder(self.head, head))
}

pub fn from_body(body: StringBuilder) -> Document {
  Document(..new(), body: body)
}

pub fn append_body(self: Document, body: StringBuilder) -> Document {
  Document(..self, body: string_builder.append_builder(self.body, body))
}

pub fn replace_body(self: Document, body: StringBuilder) -> Document {
  Document(..self, body: body)
}

pub fn into_head(state: Document) -> Document {
  Document(
    ..state,
    head: string_builder.append_builder(state.head, state.body),
    body: string_builder.new(),
  )
}

pub fn debug(state: Document) -> Document {
  let doctype_line =
    state.doctype
    |> option.map(fn(doctype) { "doctype: " <> doctype <> "\n" })
    |> option.unwrap("")

  string.concat([
    doctype_line,
    "html_attrs: ",
    string_builder.to_string(state.html_attrs),
    "\nhead: ",
    string_builder.to_string(state.head),
    "\nbody: ",
    string_builder.to_string(state.body),
    "\nscripts: ",
    string_builder.join(state.scripts, "\n")
    |> string_builder.to_string(),
    "\n\n\n",
  ])
  |> io.println()

  state
}

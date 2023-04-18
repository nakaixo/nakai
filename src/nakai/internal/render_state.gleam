import gleam/io
import gleam/option.{Option}
import gleam/list
import gleam/string
import gleam/string_builder.{StringBuilder}

pub type State {
  State(
    doctype: Option(String),
    html_attrs: StringBuilder,
    head: StringBuilder,
    body: StringBuilder,
    scripts: List(StringBuilder),
  )
}

pub fn new() {
  State(
    doctype: option.None,
    html_attrs: string_builder.new(),
    head: string_builder.new(),
    body: string_builder.new(),
    scripts: [],
  )
}

pub fn append(self: State, new: State) -> State {
  State(
    // Overwrite the doctype with a newer one, unless the newer one is `None`
    doctype: option.or(new.doctype, self.doctype),
    html_attrs: string_builder.append_builder(self.html_attrs, new.html_attrs),
    head: string_builder.append_builder(self.head, new.head),
    body: string_builder.append_builder(self.body, new.body),
    scripts: list.append(self.scripts, new.scripts),
  )
}

pub fn from_doctype(doctype: String) -> State {
  State(..new(), doctype: option.Some(doctype))
}

pub fn append_html_attrs(self: State, html_attrs: StringBuilder) -> State {
  State(
    ..self,
    html_attrs: string_builder.append_builder(self.html_attrs, html_attrs),
  )
}

pub fn from_head(head: StringBuilder) -> State {
  State(..new(), head: head)
}

pub fn append_head(self: State, head: StringBuilder) -> State {
  State(..self, head: string_builder.append_builder(self.head, head))
}

pub fn from_body(body: StringBuilder) -> State {
  State(..new(), body: body)
}

pub fn append_body(self: State, body: StringBuilder) -> State {
  State(..self, body: string_builder.append_builder(self.body, body))
}

pub fn replace_body(self: State, body: StringBuilder) -> State {
  State(..self, body: body)
}

pub fn into_head(state: State) -> State {
  State(
    ..state,
    head: string_builder.append_builder(state.head, state.body),
    body: string_builder.new(),
  )
}

pub fn debug(state: State) -> State {
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

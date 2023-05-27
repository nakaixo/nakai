import gleam/string_builder.{StringBuilder}
import nakai/html.{Node}
import nakai/internal/render

/// ## Examples
/// ```gleam
/// html.div_text([], "hello, lucy!")
/// |> nakai.to_string_builder()
/// ```
pub fn to_string_builder(tree: Node(a)) -> StringBuilder {
  render.render_document(tree)
}

/// ## Examples
/// ```gleam
/// html.div_text([], "hello, lucy!")
/// |> nakai.to_string()
/// ```
pub fn to_string(tree: Node(a)) -> String {
  render.render_document(tree)
  |> string_builder.to_string()
}

pub fn to_inline_string_builder(tree: Node(a)) -> StringBuilder {
  render.render_inline(tree)
}

pub fn to_inline_string(tree: Node(a)) -> String {
  render.render_inline(tree)
  |> string_builder.to_string()
}

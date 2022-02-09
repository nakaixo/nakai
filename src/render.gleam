import gleam/list
import gleam/string_builder.{StringBuilder}
import html/attrs.{Attr}
import node.{Doctype, Node}

pub fn render(doctype: Doctype, root: Node) -> String {
  let doctype_txt =
    string_builder.from_strings(["<!DOCTYPE ", doctype.decl, ">"])
  let txt = render_node(root)

  string_builder.to_string(string_builder.concat([
    doctype_txt,
    txt,
    string_builder.from_string("\n"),
  ]))
}

pub fn render_attrs(attrs: List(Attr)) -> StringBuilder {
  list.fold(
    attrs,
    string_builder.from_string(""),
    fn(txt: StringBuilder, attr: Attr) {
      string_builder.append_builder(
        txt,
        string_builder.from_strings([" ", attr.name, "=\"", attr.value, "\""]),
      )
    },
  )
}

pub fn render_children(children: List(Node)) -> StringBuilder {
  list.fold(
    children,
    string_builder.from_string(""),
    fn(txt, child) { string_builder.append_builder(txt, render_node(child)) },
  )
}

pub fn render_node(tree: Node) -> StringBuilder {
  case tree {
    node.Comment(content) ->
      string_builder.from_strings(["<!-- ", content, " -->"])
    node.Element(tag, attrs, children) -> {
      let txt = string_builder.from_strings(["<", tag])
      let txt = string_builder.append_builder(txt, render_attrs(attrs))
      let txt = string_builder.append(txt, ">")
      let txt = string_builder.append_builder(txt, render_children(children))
      string_builder.append_builder(
        txt,
        string_builder.from_strings(["</", tag, ">"]),
      )
    }
    node.Fragment(children) -> render_children(children)
    node.LeafElement(tag, attrs) -> {
      let txt = string_builder.from_strings(["<", tag])
      let txt = string_builder.append_builder(txt, render_attrs(attrs))
      string_builder.append(txt, "/>")
    }
    node.None -> string_builder.from_string("")
    node.Text(content) -> string_builder.from_string(content)
  }
}

import gleam/list
import gleam/string_builder.{StringBuilder}
import nakai/html.{Node}
import nakai/html/attrs.{Attr, Event}
import nakai/html/doctype.{Doctype}
import nakai/render/state.{EventState, State}

pub type AttrRender(a) {
  AttrRender(text: StringBuilder, events: List(EventState(a)))
}

pub fn new() -> AttrRender(a) {
  AttrRender(string_builder.new(), [])
}

pub fn append(before: AttrRender(a), add: AttrRender(a)) -> AttrRender(a) {
  AttrRender(
    string_builder.append_builder(before.text, add.text),
    list.append(before.events, add.events),
  )
}

pub fn render_attr(attr: Attr(a)) -> AttrRender(a) {
  case attr {
    Attr(name, value) ->
      string_builder.from_strings([" ", name, "=\"", value, "\""])
      |> AttrRender([])
    Event(name, action) -> {
      let ref = "test-ref"
      string_builder.from_strings([" data-nakai-ref-", name, "=\"", ref, "\""])
      |> AttrRender([EventState(name, ref, action)])
    }
  }
}

pub fn render_attrs(attrs: List(Attr(a))) -> AttrRender(a) {
  attrs
  |> list.map(render_attr)
  |> list.fold(new(), append)
}

pub fn render_children(children: List(Node(a))) -> State(a) {
  children
  |> list.map(render_node)
  |> list.fold(state.new(), state.append)
}

pub fn render_doctype(doctype: Doctype) -> StringBuilder {
  string_builder.from_strings(["<!DOCTYPE ", doctype.decl, ">"])
}

pub fn render_node(tree: Node(a)) -> State(a) {
  case tree {
    html.Head(children) ->
      render_children(children)
      |> state.headify

    html.Component(factory) -> render_node(factory())

    html.Fragment(children) -> render_children(children)

    html.Comment(content) ->
      string_builder.from_strings(["<!-- ", content, " -->"])
      |> state.body_only([])

    html.Element(tag, attrs, children) -> {
      let state = render_children(children)
      let attr_render = render_attrs(attrs)
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        attr_render.text,
        string_builder.from_string(">"),
        state.body,
        string_builder.from_strings(["</", tag, ">"]),
      ])
      |> State(state.head, _, list.append(state.events, attr_render.events))
    }

    html.LeafElement(tag, attrs) -> {
      let attr_render = render_attrs(attrs)
      string_builder.concat([
        string_builder.from_strings(["<", tag]),
        attr_render.text,
        string_builder.from_string(" />"),
      ])
      |> state.body_only(attr_render.events)
    }

    html.Text(content) ->
      string_builder.from_string(content)
      |> state.body_only([])

    html.Nothing -> state.new()
  }
}

pub fn render_root(tree: Node(a), attrs: List(Attr(a))) -> StringBuilder {
  let result = render_node(tree)
  let attr_render = render_attrs(attrs)
  let events = list.append(result.events, attr_render.events)
  string_builder.concat([
    string_builder.from_string("<html"),
    attr_render.text,
    string_builder.from_string(">\n<head>"),
    result.head,
    string_builder.from_string("</head>\n<body>"),
    result.body,
    generate_events_code(events),
    string_builder.from_string("</body>\n</html>"),
  ])
}

fn generate_events_code(events: List(EventState(a))) -> StringBuilder {
  case events {
    [] -> string_builder.new()
    _ ->
      events
      |> list.map(fn(event) {
        let selector =
          string_builder.from_strings([
            "[data-nakai-ref-",
            event.name,
            "=\"",
            event.ref,
            "\"]",
          ])
          |> string_builder.to_string
        string_builder.from_strings([
          "window.addEventListener(\"DOMContentLoaded\", function() {
          document.querySelector('",
          selector,
          "')
          .addEventListener('",
          event.name,
          "', () => console.log(\"doing the thing!!!\"));
          });\n",
        ])
      })
      |> string_builder.concat
      |> string_builder.prepend("<script>\n")
      |> string_builder.append("\n</script>")
  }
}

import gleam/list
import gleam/string_builder.{StringBuilder}

pub type State(a) {
  State(head: StringBuilder, body: StringBuilder, events: List(EventState(a)))
}

pub type EventState(a) {
  EventState(name: String, ref: String, a)
}

pub fn new() {
  State(string_builder.new(), string_builder.new(), [])
}

pub fn head_only(head: StringBuilder) -> State(a) {
  State(head, string_builder.new(), [])
}

pub fn body_only(body: StringBuilder, events: List(EventState(a))) -> State(a) {
  State(string_builder.new(), body, events)
}

pub fn append(before: State(a), add: State(a)) {
  State(
    string_builder.append_builder(before.head, add.head),
    string_builder.append_builder(before.body, add.body),
    list.append(before.events, add.events),
  )
}

pub fn headify(state: State(a)) -> State(a) {
  head_only(state.body)
}

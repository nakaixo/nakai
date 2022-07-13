import gleam/list
import gleam/string

pub type Path {
  Absolute(segments: List(String))
  Relative(segments: List(String))
}

pub type PathFilter {
  Up
  Skip
  Include
}

fn filter_segment_list(path: Path) -> Path {
  let constructor = case path {
    Absolute(_) -> Absolute
    Relative(_) -> Relative
  }

  let segments = path.segments

  segments
  |> list.fold(
    [],
    fn(segments, segment) {
      case filter_segment(segment) {
        Up ->
          case path, list.all(segments, fn(segment) { segment == ".." }) {
            Relative(_), True -> list.append(segments, [".."])
            _, _ -> list.take(segments, list.length(segments) - 1)
          }
        Skip -> segments
        Include -> list.append(segments, [segment])
      }
    },
  )
  |> constructor
}

fn filter_segment(segment: String) -> PathFilter {
  case segment {
    "" | "." -> Skip
    ".." -> Up
    _ -> Include
  }
}

pub fn from_string(base: String) -> Path {
  let constructor = case string.starts_with(base, "/") {
    True -> Absolute
    False -> Relative
  }

  base
  |> string.split("/")
  |> constructor
  |> filter_segment_list
}

pub fn join(path: Path, piece: String) -> Path {
  let constructor = case path {
    Absolute(_) -> Absolute
    Relative(_) -> Relative
  }

  let segments = path.segments

  piece
  |> string.split("/")
  |> list.append(segments, _)
  |> constructor
  |> filter_segment_list
}

pub fn to_string(path: Path) -> String {
  let joined_segments = string.join(path.segments, "/")

  case path {
    Absolute(_) -> string.concat(["/", joined_segments])
    Relative(_) -> joined_segments
  }
}

pub fn normalize(messy: String) -> String {
  messy
  |> from_string
  |> to_string
}

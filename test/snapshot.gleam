import gleam/erlang/file
import gleam/erlang/os
import gleam/string_builder.{StringBuilder}
import gleeunit/should

pub fn match(result: StringBuilder, snapshot_file: String) {
  let result = string_builder.to_string(result)

  case os.get_env("SNAPSHOT") {
    // Check against existing snapshots!
    Error(Nil) | Ok("0") | Ok("false") ->
      should.equal(Ok(result), file.read(snapshot_file))
    // Update all of the result snapshots
    _ -> {
      let _ = file.write(result, snapshot_file)
      Nil
    }
  }
}

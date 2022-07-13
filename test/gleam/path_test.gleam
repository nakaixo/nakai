import gleam/path
import gleeunit/should

pub fn from_string_test() {
  path.from_string("/hello/friend")
  |> should.equal(path.Absolute(["hello", "friend"]))
  path.from_string("/hello/friend/../buddy")
  |> should.equal(path.Absolute(["hello", "buddy"]))
  path.from_string("hello/friend")
  |> should.equal(path.Relative(["hello", "friend"]))
  path.from_string("./hello/./friend/../buddy")
  |> should.equal(path.Relative(["hello", "buddy"]))
}

pub fn join_test() {
  path.join(path.Absolute(["hello", "there"]), "buddy/pal")
  |> should.equal(path.Absolute(["hello", "there", "buddy", "pal"]))
  path.join(path.Absolute(["hello", "there"]), "../sailor")
  |> should.equal(path.Absolute(["hello", "sailor"]))
}

pub fn normalize_test() {
  path.normalize("/hello/./there/../friend")
  |> should.equal("/hello/friend")
  path.normalize("hello/./there/../friend")
  |> should.equal("hello/friend")
  path.normalize("/hello/./there/../../../goodbye/forever")
  |> should.equal("/goodbye/forever")
  path.normalize("hello/./there/../../../goodbye/forever")
  |> should.equal("../goodbye/forever")
  path.normalize("/hello/./there/../../../goodbye/forever/../../../hello/again")
  |> should.equal("/hello/again")
  path.normalize("hello/./there/../../../goodbye/forever/../../../hello/again")
  |> should.equal("../../hello/again")
  path.normalize("../../../hello/sailor")
  |> should.equal("../../../hello/sailor")
}

import gleam/erlang
import gleam/io
import run

pub fn main() {
  io.println("nakai: Starting...")
  let _ = run.start()
  io.println("nakai: Ready! http://localhost:3000/")
  erlang.sleep_forever()
}

import glychee/benchmark
import nakai
import nakai/integration/info
import nakai/integration/puppies

pub fn main() {
  benchmark.run(
    [
      benchmark.Function(
        label: "nakai.to_string_builder",
        callable: fn(app) { fn() { nakai.to_string_builder(app()) } },
      ),
    ],
    [
      benchmark.Data(label: "xs", data: info.app),
      benchmark.Data(label: "sm", data: puppies.app),
    ],
  )
}

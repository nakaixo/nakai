import glychee/benchmark
import nakai
import nakai/integration/info
import nakai/integration/puppies

const benchmark_data = [
  benchmark.Data(label: "xs", data: info.app),
  benchmark.Data(label: "sm", data: puppies.app),
]

pub fn main() {
  [
    benchmark.Function("nakai.to_string_builder", fn(app) {
      fn() { nakai.to_string_builder(app()) }
    }),
    benchmark.Function("nakai.to_inline_string_builder", fn(app) {
      fn() { nakai.to_inline_string_builder(app()) }
    }),
  ]
  |> benchmark.run(benchmark_data)
}

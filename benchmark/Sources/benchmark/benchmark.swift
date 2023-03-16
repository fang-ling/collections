import CollectionsBenchmark

@main
public struct Main {
    public static func main() {
        var benchmark = Benchmark(title: "Collection Benchmarks")
        benchmark.add_array_benchmarks()
        benchmark.add_binary_heap_benchmarks()
        benchmark.add_red_black_tree_benchmarks()
        benchmark.main()
    }
}

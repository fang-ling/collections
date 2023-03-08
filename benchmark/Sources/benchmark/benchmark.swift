import CollectionsBenchmark

@main
public struct Main {
    public static func main() {
        var benchmark = Benchmark(title: "Collection Benchmarks")
        benchmark.add_array_benchmarks()
        benchmark.main()
    }
}

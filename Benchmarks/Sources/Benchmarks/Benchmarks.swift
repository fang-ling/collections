import CollectionsBenchmark

@main
public struct Benchmarks {
    public static func main() {
        var benchmark = Benchmark(title: "Collection Benchmarks")
//        benchmark.add_swift_heap_benchmark()
//        benchmark.add_veb_tree_benchmark()
        benchmark.add_doubly_linked_list_benchmark()
        benchmark.add_swift_deque_benchmark()
        benchmark.main()
    }
}

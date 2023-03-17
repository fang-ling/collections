@main
public struct Benchmarks {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(Benchmarks().text)
    }
}

@main
public struct benchmark {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(benchmark().text)
    }
}

swift run -c release -Xswiftc -Ounchecked Benchmarks library run .result/results.json --library $1 --cycles $2
swift run -c release -Xswiftc -Ounchecked Benchmarks library render .result/results.json --library $1 --percentile 90 --amortized false --output .result

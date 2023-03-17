swift run -c release Benchmarks library run results.json --library $1 --cycles $2
swift run -c release Benchmarks library render results.json --library $i --percentile 90 --amortized false --output .result

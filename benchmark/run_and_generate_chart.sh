swift run -c release benchmark library run results.json --library Library.json --cycles 3
swift run -c release benchmark library render results.json --library Library.json --percentile 90 --amortized false --output .

swift run -c release benchmark library run results.json --library Library.json --cycles 3
swift run -c release benchmark library render results.json --library Library.json --max-time 10us --min-time 1ns --percentile 90 --linear-size --amortized false --output .

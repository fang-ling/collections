swift run -c release benchmark library run results.json --library Library.json --cycles 20
swift run -c release benchmark library render results.json --library Library.json --max-time 10us --min-time 1ns  --percentile 90 --output .

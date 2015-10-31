let rec zip xs ys = match xs, ys with
| [], ys -> ys
| xs, [] -> xs
| x :: xs, y :: ys -> x :: y :: zip xs ys

let rec runenc ys xs = match xs, ys with
| []     , ys                      -> ys
| x :: xs, (y, n) :: ys when x = y -> runenc ((y, n+1) :: ys) xs
| x :: xs, ys                      -> runenc ((x, 1) :: ys) xs

let rec histo xs =
xs |> List.sort compare |> runenc []

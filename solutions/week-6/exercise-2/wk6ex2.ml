let rec hasnext y = function
| []                       -> false
| (y', z) :: _ when y = y' -> true
| _ :: ys                  -> hasnext y ys;;
 
let rec getnext y xs' = function
| [] -> failwith "getnext"
| (y', z) :: xs when y = y' -> (y', z), xs' @ xs
| x :: ys -> getnext y (x :: xs') ys;;
 
let rec loop = function
| [] -> true
| [x, y] -> x = y
| (x, y) :: edges ->
  hasnext y edges &&
  let (y', z), edges' = getnext y [] edges in
  loop ((x, z) :: edges');;
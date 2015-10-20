open Common;;

let days_of_october n = match (n - 1) mod 7 with
  | 0 -> Wed
  | 1 -> Thu
  | 2 -> Fri
  | 3 -> Sat
  | 4 -> Sun
  | 5 -> Mon
  | _ -> Tue;;

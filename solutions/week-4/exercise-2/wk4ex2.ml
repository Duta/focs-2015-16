let dec (a, b) = 
  let f x = match x with
  | true -> a
  | false -> b in
  f;;

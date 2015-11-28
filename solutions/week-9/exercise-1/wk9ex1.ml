open Common;;

let rec sub a b = match a, b with
| Zero, Suc _  -> failwith "sub"
| x, Zero      -> x
| Suc x, Suc y -> sub x y;;

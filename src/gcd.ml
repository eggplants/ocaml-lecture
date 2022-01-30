exception GcdArgError of string

(* val gcd : int -> int -> int = <fun>*)
let rec gcd a b =
  if a < 1 || b < 1 then raise (GcdArgError "gimme positive int!")
  else if a < b then gcd b a
  else if a mod b = 0 then b
  else gcd b a mod b

let () = print_int (gcd 100 0)

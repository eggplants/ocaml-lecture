type rational = { num : int; den : int }

exception GcdArgError of string

let rec gcd a b =
  let g = a mod b in
  if a < 0 || b < 0 then raise (GcdArgError "gimme positive int!")
  else if a < b then gcd b a
  else if g = 0 then b
  else gcd b g

let sum r1 r2 =
  let r3_num = (r1.num * r2.den) + (r2.num * r1.den) in
  (* 分子 *)
  let r3_den = r1.den * r2.den in
  (* 分母 *)
  let g = gcd r3_num r3_den in
  (* 約分する数を求める *)
  { num = r3_num / g; den = r3_den / g }

let res = sum { num = 1; den = 2 } { num = 1; den = 6 }

let () = Printf.printf "res: %d/%d\n" res.num res.den

(* 式表現の文法定義 *)
type expr =
  | Plus of expr * expr (* means a + b *)
  | Minus of expr * expr (* means a - b *)
  | Times of expr * expr (* means a * b *)
  | Divide of expr * expr (* means a / b *)
  | Value of string

(* 式を文字列に変換 *)
let rec to_string e =
  match e with
  | Plus (left, right) -> "(" ^ to_string left ^ " + " ^ to_string right ^ ")"
  | Minus (left, right) -> "(" ^ to_string left ^ " - " ^ to_string right ^ ")"
  | Times (left, right) -> "(" ^ to_string left ^ " * " ^ to_string right ^ ")"
  | Divide (left, right) -> "(" ^ to_string left ^ " / " ^ to_string right ^ ")"
  | Value v -> v

(* 掛け算を分配 *)
let rec multiply_out e =
  match e with
  (* (\* a (+ b c)) *)
  | Times (e1, Plus (e2, e3)) ->
      Plus
        ( Times (multiply_out e1, multiply_out e2),
          Times (multiply_out e1, multiply_out e3) )
  (* (\* (+ a b) c) *)
  | Times (Plus (e1, e2), e3) ->
      Plus
        ( Times (multiply_out e1, multiply_out e3),
          Times (multiply_out e2, multiply_out e3) )
  (* 各要素に対しても適用 *)
  | Plus (left, right) -> Plus (multiply_out left, multiply_out right)
  | Minus (left, right) -> Minus (multiply_out left, multiply_out right)
  | Times (left, right) -> Times (multiply_out left, multiply_out right)
  | Divide (left, right) -> Divide (multiply_out left, multiply_out right)
  (* 値はそのまま返す *)
  | Value v -> Value v

let print_expr e = print_endline (to_string e)

let () =
  print_endline (to_string (Times (Value "n", Plus (Value "x", Value "y"))))

let () =
  print_expr (multiply_out (Times (Value "n", Plus (Value "x", Value "y"))))

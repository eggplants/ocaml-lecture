exception MoneyUnitError of string

exception RoundReturnTypeError

type money = Doller of float | Yen of int

type number = Int of int | Float of float

let yen_of_int n = Yen (int_of_float n)

let doller_of_float n = Doller n

let round n = floor (n +. 0.5)

let yen_of_doller n =
  match n with
  | Doller n -> 111.12 *. n |> round |> yen_of_int
  | _ -> raise (MoneyUnitError "hai.")

let doller_of_yen n =
  match n with
  | Yen n ->
      float_of_int n |> (fun n -> n /. 111.12) |> round |> doller_of_float
  | _ -> raise (MoneyUnitError "hai.")

let () =
  match yen_of_doller (Doller 12.0) with
  | Yen n -> Printf.printf "$12.0 -> ￥%d\n" n
  | _ -> raise (MoneyUnitError "hai.")

let () =
  match doller_of_yen (Yen 10000) with
  | Doller n -> Printf.printf "￥10000 -> $%0.1f\n" n
  | _ -> raise (MoneyUnitError "hai.")

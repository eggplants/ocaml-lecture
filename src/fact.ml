let rec _fact n r = match n with 0 -> r | _ -> _fact (n - 1) (n * r)

let rec fact n = _fact n 1

let () = print_int (fact 10)

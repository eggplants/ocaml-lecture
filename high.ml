let fum higher f g x = f (g x)

let rec iterate f x n = match n with 0 -> x | _ -> iterate f (f x) (n - 1)

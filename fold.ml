let rec f_left func def lis =
  match lis with [] -> def | x :: xs -> f_left func (func def x) xs

let rec f_right func lis def =
  match lis with [] -> def | x :: xs -> func x (f_right func xs def)

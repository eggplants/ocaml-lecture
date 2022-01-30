type bt = Leaf of int | Tree of bt * bt

let rec _sumtree (t : bt) (r : int) =
  match t with
  | Leaf n -> n + r
  | Tree (x, y) -> r + _sumtree x r + _sumtree y r

let rec sumtree t : bt = _sumtree t 0

(* 
Leaf 3
Tree (Leaf 3, Leaf 4)
Tree (Tree (Leaf 3, Leaf 4), Leaf 5)
Tree (Tree (Leaf 3, Leaf 4), Tree (Tree (Leaf 3, Leaf 4), Leaf 5))
*)

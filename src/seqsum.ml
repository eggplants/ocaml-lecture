exception SeqsumArgError of string

let rec _seqsum n x =
  if n <= 0 then raise (SeqsumArgError "gimme positive int!")
  else if n = 1 then x
  else _seqsum (n - 1) (x + n)

let rec seqsum n = _seqsum n 1

let () = print_int (seqsum 10)

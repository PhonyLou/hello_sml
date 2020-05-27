datatype mytype = TwoInts of int*int
                | Str of string
                | Pizza

(* function mytype -> int *)
fun f x =
    case x of
        Pizza => 1
     |  Str s => 2
     |  TwoInts(i1, i2) => 3
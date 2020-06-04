fun map(f,xs) =
    case xs of
        [] => []
        | x::xs' => (f x)::map(f,xs')

val x1 = map((fn x=>x+1), [1,2,5,6])
val x2 = map(hd, [[1,2,4], [8,3,4], [555,5]])

fun filter(f,xs) =
    case xs of 
        [] => []
        | x::xs' => if f x then x::(filter(f,xs'))
                    else filter(f,xs')
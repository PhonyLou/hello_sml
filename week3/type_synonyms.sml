datatype suit = Club | Diamond | Heart | Spade
datatype rank = A | B | C

type card = suit * rank

fun is_Club_A (c : card) =
    #1 c = Club andalso #2 c = A

val c1: card = (Club, B)
val c2: suit*rank = (Club, C)

fun is_Club_A2 c =
    case c of 
        (Club, A) => true
       | _ => false

fun some_list xs =
    case xs of
        [] => 0
        | x :: xs' => x + some_list xs'
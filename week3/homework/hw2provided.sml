(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
fun all_except_option (s: string, xs: string list) =
   let
      fun loop(lst: string list, res: string list) =
         case res of
            [] => NONE
            | x :: xs' => if same_string (s, x) 
                          then SOME (lst @ xs')
                          else loop(lst @ [x], xs')
   in
      loop([], xs)
   end

fun get_substitutions1 (s: string list list, k: string) =
   case s of 
      [] => []
      | x :: s' => 
         case all_except_option(k,x) of
            NONE => get_substitutions1(s', k)
            | SOME xs => xs @ get_substitutions1(s', k)

fun get_substitutions2 (s: string list list, k: string) =
   let
      fun loop (s: string list list, acc: string list) =
         case s of 
            [] => acc
            | s' :: xs => 
               case all_except_option(k, s') of
                  NONE => loop(xs, acc)
                  | SOME v => loop(xs, acc @ v)
   in
      loop(s, [])
   end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

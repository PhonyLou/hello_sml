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

fun similar_names (s: string list list, name: {first:string,middle:string,last:string}) =
   let
      val {first=x,middle=y,last=z} = name
      val first_names = [x] @ get_substitutions2(s, x)
      fun loop (s: string list, names: {first:string,middle:string,last:string} list) =
         case s of 
            [] => names
            | s' :: xs => loop(xs, names @ [{first=s', middle=y, last=z}])
   in
      loop (first_names, [])
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
fun card_color (aCard: card) =
   case aCard of 
      (Clubs, _) => Black
      | (Spades, _) => Black
      | _ => Red

fun card_value(aCard: card) =
   case aCard of
      (_, Num x) => x
      | (_, Ace) => 11
      | _ => 10

fun remove_card(cs: card list, c: card, e: exn) =
   let
      fun loop(cs: card list, ncs: card list, withCard: bool) =
         case cs of
            [] => if withCard then ncs else raise e
            | aCard :: cs' => if aCard=c andalso withCard=false 
                              then loop(cs', ncs, true)
                              else loop(cs', ncs @ [aCard], withCard)
   in
      loop(cs, [], false)
   end

fun all_same_color(cs: card list) =
   case cs of
      [] => true
      | c1 :: c2 :: cs' => (card_color(c1)=card_color(c2)) andalso all_same_color(c2::cs')
      | c1 :: [] => true

fun sum_cards(cs: card list) =
   let
      fun loop(cs: card list, acc: int) =
         case cs of 
            [] => acc
            | aCard :: cs' => loop(cs', card_value(aCard) + acc)
   in
      loop(cs, 0)
   end

fun score(cs: card list, g: int) =
   let
      val sum = sum_cards(cs)
      val pre = if sum > g
                  then 3 * (sum-g)
                  else g-sum
   in
      if all_same_color(cs)
      then pre div 2
      else pre
   end
   

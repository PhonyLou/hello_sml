(* This is a comment. This first *)
val x = 34;

val y = 17;

val z = (x + y) + (y + 2);

val abs_of_z = if z < 0 then 0 - z else z;
(* static : int*)
(* dynamic environment : abs_of_z --> 70*)

val abs_of_z_simple = abs z;
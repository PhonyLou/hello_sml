fun double x = x*2
fun incre x = x+1

val a_tuple = (double, incre, double (incre 7))

val eighteen = (#1 a_tuple) 9
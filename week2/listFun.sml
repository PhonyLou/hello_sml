fun list_product(xs: int list) =
    if null xs
    then 1
    else hd xs * list_product (tl xs)


fun append(xs : int list, ys : int list) =
    if null xs
    then ys
    else (hd xs) :: append((tl xs), ys)



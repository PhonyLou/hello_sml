fun is_older(first: int*int*int, second: int*int*int) =
    if #1 first <= #1 second andalso #2 first <= #2 second andalso #3 first < #3 second
    then true
    else false

fun number_in_month(dates: (int*int*int) list, month: int) =
    let
        fun is_in_month(date: int*int*int, month: int) =
            if #2 date = month
            then true
            else false

        fun loop(count: int, dates: (int*int*int) list, month: int) = 
            if null dates
            then
                count
            else
                if is_in_month(hd dates, month)
                then loop(count+1, tl dates, month)
                else loop(count, tl dates, month)
    in
        loop(0, dates, month)
    end


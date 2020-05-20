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

fun number_in_months(dates: (int*int*int) list, months: int list) =
    let
        fun loop(count: int, months: int list) = 
            if null months
            then count
            else
                loop(count+number_in_month(dates, hd months), tl months)

    in
        loop(0, months)
    end

fun dates_in_month(dates: (int*int*int) list, month: int) =
    let
        fun loop(in_month_datas: (int*int*int) list, dates: (int*int*int) list) =
            if null dates
            then in_month_datas
            else
                if #2 (hd dates) = month
                then loop(in_month_datas @ [(hd dates)], tl dates)
                else loop(in_month_datas, tl dates)
    in
        loop([], dates)
    end
    
fun dates_in_months(dates: (int*int*int) list, months: int list) =
    let
        fun loop(dates_in_months: (int*int*int) list, months: int list) =
            if null months
            then dates_in_months
            else
                loop(dates_in_months @ dates_in_month(dates, hd months), tl months)
    in
        loop([], months)
    end

fun get_nth(strings: string list, n: int) =
    let
        fun loop(index: int, strings: string list) =
            if index=n
            then hd strings
            else loop(index+1, tl strings)
    in
        loop(1, strings)
    end

fun date_to_string(date: int*int*int) =
    let
        fun months() =
            ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
        get_nth(months(), #2 date) ^ " " ^Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date) 
    end

fun number_before_reaching_sum(sum: int, xs: int list) =
    let
        fun loop(sums: int, n: int, xs: int list) =
            if sums >= sum
            then n-1
            else loop(hd (tl xs) + sums, n+1, tl xs)
    in
        loop(hd xs, 1, xs)
    end

fun what_month(dayOfYear: int) =
    let
        fun dates() =
            [31,28,31,30,31,30,31,31,30,31,30,31]
        fun is_reach_date(sum: int, n: int, dates: int list) =
            if n=0
            then 
                if sum<dayOfYear
                then false
                else true
            else 
                is_reach_date(hd dates + sum, n-1, tl dates)
    in
        if is_reach_date(0, number_before_reaching_sum(dayOfYear, dates()), dates())
        then number_before_reaching_sum(dayOfYear, dates())
        else number_before_reaching_sum(dayOfYear, dates()) + 1
    end
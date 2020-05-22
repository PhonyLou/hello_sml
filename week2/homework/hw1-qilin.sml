fun is_older(first: int*int*int, second: int*int*int) =
    let
        val y1 = #1 first
        val m1 = #2 first
        val d1 = #3 first
        val y2 = #1 second
        val m2 = #2 second
        val d2 = #3 second
    in
        y1<y2 orelse (y1=y2 andalso m1<m2) orelse (y1=y2 andalso m1=m2 andalso d1<d2)
    end

fun number_in_month(dates: (int*int*int) list, month: int) =
    if null dates
    then 0
    else if #2 (hd dates) = month
    then 1 + number_in_month(tl dates, month)
    else number_in_month(tl dates, month)

fun number_in_months(dates: (int*int*int) list, months: int list) =
    let
        fun loop(count: int, months: int list) = 
            if null months
            then count
            else loop(count+number_in_month(dates, hd months), tl months)
    in loop(0, months)
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
    in loop([], dates)
    end
    
fun dates_in_months(dates: (int*int*int) list, months: int list) =
    let
        fun loop(dates_in_months: (int*int*int) list, months: int list) =
            if null months
            then dates_in_months
            else
                loop(dates_in_months @ dates_in_month(dates, hd months), tl months)
    in loop([], months)
    end

fun get_nth(strings: string list, n: int) =
    let
        fun loop(index: int, strings: string list) =
            if index=n
            then hd strings
            else loop(index+1, tl strings)
    in loop(1, strings)
    end

fun date_to_string(date: int*int*int) =
    let
        fun months() =
            ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in get_nth(months(), #2 date) ^ " " ^Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date) 
    end

fun number_before_reaching_sum(sum: int, xs: int list) =
    let
        fun loop(sums: int, n: int, xs: int list) =
            if sums >= sum
            then n-1
            else loop(hd (tl xs) + sums, n+1, tl xs)
    in loop(hd xs, 1, xs)
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

fun month_range(day1: int, day2: int) =
    if day1>day2
    then []
    else what_month day1 :: month_range(day1+1, day2)

fun oldest(dates: (int*int*int) list) =
    let
        fun loop(oldest: int*int*int, dates: (int*int*int) list) =
            if null dates
            then oldest
            else 
                if is_older(oldest, hd dates)
                then loop(oldest, tl dates)
                else loop(hd dates, tl dates) 
    in
        if null dates
        then NONE
        else SOME (loop(hd dates, dates))
    end

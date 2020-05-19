fun is_older(first: int*int*int, second: int*int*int) =
    if #1 first <= #1 second andalso #2 first <= #2 second andalso #3 first < #3 second
    then true
    else false
We have removed the characters {,}," from the string and then converted : to /
We have then used awk, passed our substring as delimiter and got the second part.
Then finally converted / to get our desired output.

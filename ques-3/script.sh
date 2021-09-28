cat file.txt | tr -d '"'|tr -d "{"|tr -d "}"|tr ":" "/"|awk -F "a/b" '{print $2}'|tr "/" " "

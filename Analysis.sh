#!/bin/sh

#Analyze all files
totalfiles=`git ls-files | wc -l`
totallines=`git ls-files --exclude-standard | wc -l`
totalbytes=`git ls-files --exclude-standard | wc -c`

echo -e "In the git repository, there are $totalfiles files, $totallines lines of code, taking up $totalbytes byt$

#Analyze swift files
swiftfilenames=`git ls-files | grep '\.swift'`
swiftcontents=`echo "$swiftfilenames" | xargs cat`

swiftfiles=`echo "$swiftfilenames" | wc -l`
swiftlines=`echo "$swiftcontents" | wc -l`
swiftbytes=`echo "$swiftcontents" | wc -c`
swiftclasses=`echo "$swiftcontents" | grep -wc "^class\|public class\|private class"`
swiftfunctions=`echo "$swiftcontents" | grep -n "func " | wc -l`
swiftcomments=`echo "$swiftcontents" | grep -wc "//"`

echo -e "In $swiftfiles swift files, there are a total of $swiftlines lines of code taking up $swiftbytes bytes.\$
echo -e "There are $swiftcomments comments.\n"
echo "There are $swiftclasses different classes, below are their locations."
echo "$swiftfilenames" | xargs grep -n "^class\|public class\|private class"
echo -e "\nThere are $swiftfunctions functions, below are their locations."
echo "$swiftfilenames" | xargs grep -n "func "
#!/bin/sh

#Analyze all files
totalfiles=`git ls-files | wc -l`
totallines=`git ls-files --exclude-standard | xargs  cat |  wc -l`
totalbytes=`git ls-files --exclude-standard | wc -c`

echo "In the git repository, there are $totalfiles files, $totallines lines of code, taking up $totalbytes bytes\n"

#Analyze swift files
swiftfilenames=`git ls-files | grep '\.swift'`
swiftcontents=`echo "$swiftfilenames" | xargs cat`

swiftfiles=`echo "$swiftfilenames" | wc -l`
swiftlines=`echo "$swiftcontents" | wc -l`
swiftbytes=`echo "$swiftcontents" | wc -c`
swiftclasses=`echo "$swiftcontents" | grep -wc "^class\|public class\|private class"`
swiftfunctions=`echo "$swiftcontents" | grep -n "func " | wc -l`
swifttestfunctions=`echo "$swiftcontents" | grep -n "func test" | wc -l`
swiftstructs=`echo "$swiftcontents" | grep -n "struct " | wc -l`
swiftcomments=`echo "$swiftcontents" | grep -wc "//\|\*/"`

echo "In $swiftfiles swift files, there are a total of $swiftlines lines of code taking up $swiftbytes bytes.\n"
echo "There are $swiftcomments comments.\n"
echo "There are $swiftclasses different classes and $swiftstructs different structs.\n"
#echo "$swiftfilenames" | xargs grep -n "^class\|public class\|private class"
echo "There are $swiftfunctions functions, with $swifttestfunctions test functions.\n"
#echo "$swiftfilenames" | xargs grep -n "func "

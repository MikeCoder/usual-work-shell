#!/bin/bash

source ./common/*.sh

function printMan() {
    echo "ALLCODE                       MIT LICENSE                         ALLCODE"
    echo ""
    echo "                  REMOVE THE ALL FILES WITH SAME EXTENSION"
    echo ""
    echo "NAME"
    echo "      rmFileByExtension.sh -- get all files with same extension"
    echo ""
    echo "SYNOPSIS"
    echo "      sh rmFileByExtension.sh [-dfh] [...]"
    echo ""
    echo "DESCRIPTION"
    echo "      If you want to delete all files in current folder and it's child folder,"
    echo "      with same file extension. For example, if you want to delete all png files"
    echo "      in your project folder, you can use this script."
    echo ""
    echo "     -d       Your custom directory, which use current directory default. "
    echo ""
    echo "     -f       Which extension of file type you want, such as 'java, php, sh, c'"
    echo ""
    echo "     -h       ReadMe"
    echo ""
    echo "EXAMPLES"
    echo "      The command:"
    echo ""
    echo "              sh rmFileByExtension.sh -d . -f sh"
    echo "      Result:"
    echo "              rmFilesByExtension.sh -f sql -d ."
    echo "              into /Users/Mike/dumps"
    echo "              find all sql files"
    echo "              find all sql files"
    echo "              find and remove file :  /Users/Mike/dumps/f/dd.sql"
    echo "              find all sql files"
    echo "              find all sql files"
    echo "              find and remove file :  /Users/Mike/dumps/ff/ww.sql"
    echo "              find all sql files"
    echo "              find and remove file :  /Users/Mike/dumps/fff.sql"
    echo "              finish rm code."
    echo "              done"
    echo ""
    echo "MIT                           July 11, 2016                           MIT"
}


while getopts "hd:f:" arg
do
    case $arg in
        h)
            printMan
            out=1
            ;;
        d)
            dir=$OPTARG
            ;;
        f)
            filter=$OPTARG
            ;;
        ?)
            printMan
            out=1
            ;;
    esac
done

if [[ x$out != x ]]; then
    exit
fi

if [[ x$outFile == x ]]; then
    outFile=result.txt
fi

if [[ -z "$dir" ]] || [[ ! -d "$dir" ]]; then
    read -p 'No directory declared, will use current directory instead, sure? yes|no : ' sure
    if [[ $sure == yes ]]; then
        nowdir=$(pwd)
        echo 'use current directory'
    else
        exit
    fi
else
    nowdir=$(cd $dir; pwd)
fi
echo "into $nowdir"

sureRm=false

function findAllFile() {
    echo "find all $filter files"
    if [[ x$filter == x ]]; then
        if [[ $sureRm == false ]]; then
            read -p "No extension, so dangerous, do you want go on? yes|no : " order
            if [[ $order != yes ]]; then
                exit
            else
                sureRm=true
            fi
        fi
    fi

    ls | while read var
        do
            if [[ -f $var ]]; then
                if [[ x$filter != x && $var =~ \.$filter ]]; then
                    echo 'find and remove file : ' "$(pwd)/$var"
                    rm "$(pwd)/$var"
                fi
            fi

            if [[ -d $var ]]; then
                cd "$(pwd)/$var"
                findAllFile
                cd ..
            fi
        done
}

cd $nowdir
findAllFile
echo "finish rm code."
echo "done"

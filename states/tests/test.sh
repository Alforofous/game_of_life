#!/bin/bash

BIN=$1

if [ -z "$BIN" ]
then
    echo "Usage: ./test.sh command"
    exit
fi

function do_test {
    echo $1
    $BIN $1 >> /dev/null
}

time (
do_test "empty 1000"
do_test "random 1000"
do_test "diehard 1398"
do_test "acorn 5206"
do_test "dinnertable 1000000"
do_test "big 10"
)

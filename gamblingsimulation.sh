#!/bin/bash -x
INITIAL_STAKE=100
BET=1
DAY=1
WIN=1
LOSS=0

echo "gambling simulator"

function result() 
{
        rem=$(( RANDOM%2 ))

        if [ $rem -eq 1 ]
        then
                INITIAL_STAKE=$(( INITIAL_STAKE+1 ))
        else
                INITIAL_STAKE=$(( INITIAL_STAKE-1 ))
        fi
}

result

echo $INITIAL_STAKE

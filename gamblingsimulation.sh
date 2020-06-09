#!/bin/bash -x
echo "gambling simulator"

INITIAL_STAKE=100
BET=1
DAY=1
WIN=1
LOSS=0

stake=$INITIAL_STAKE
stakePercentAmount=$(( 50*$INITIAL_STAKE/100 ))
max_win=$(( $stakePercentAmount+$INITIAL_STAKE ))
max_loss=$(( $INITIAL_STAKE-$stakePercentAmount ))
numofDays=20

function result() 
{	stake=$INITIAL_STAKE
        while [ $stake -lt $max_win ] && [ $stake -gt $max_loss ]
        do
        rem=$(( RANDOM%2 ))

         if [ $rem -eq 1 ]
         then
                stake=$(( stake+BET ))
         else
                stake=$(( stake-BET ))
         fi
        done
}

for (( day=0; day<$numofDays; day++ ))
        do
        result
                if [ $stake -eq $max_loss ]
                then
                totalWinOrloss=$(( totalWinOrloss-50 ))
                else
                totalWinOrloss=$(( totalWinOrloss+50 ))
                fi 
        echo "Resign for day"
        done

 echo $totalWinOrloss

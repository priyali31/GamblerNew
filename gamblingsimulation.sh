#!/bin/bash -x
echo "gambling simulator"

INITIAL_STAKE=100
WIN=1
LOSS=0
BET=1

stakePercentAmount=$(( 50*$INITIAL_STAKE/100 ))
maxWin=$(( $stakePercentAmount+$INITIAL_STAKE ))
maxLoss=$(( $INITIAL_STAKE-$stakePercentAmount ))
numofDays=30
totalWinOrLoss=0
daysWin=0
daysLoss=0

declare -A fullDay

function betResult()
{       dayStake=$INITIAL_STAKE
        while [ $dayStake -lt $maxWin ] && [ $dayStake -gt $maxLoss ]
        do
         rem=$(( RANDOM % 2 ))
                if [ $rem -eq 1 ]
                then
                        dayStake=$(( $dayStake+$BET ))
                else
                        dayStake=$(( $dayStake-$BET ))
                fi
        done
}
        for (( day=1; day<=$numofDays; day++ ))
        do
        betResult
                if [ $dayStake -eq $maxLoss ]
                then
                        totalWinOrloss=$(( $totalWinOrloss-$stakePercentAmount ))
                        fullDay["Day $day"]=-$stakePercentAmount
                        (( daysLoss++ ))
                else
                        totalWinOrloss=$(( $totalWinOrloss+$stakePercentAmount ))
                        fullDay["Day $day"]=$stakePercentAmount
                        (( daysWin++ ))
                fi
        done

echo "Winned days $daysWin by $(($daysWin*$stakePercentAmount))" 
echo "Lossed days $daysLoss by  $(($daysLoss*$stakePercentAmount))"

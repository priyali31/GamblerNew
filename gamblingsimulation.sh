
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
declare -A maxMinDay

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
                       totalWinOrloss=$(( $totalWinOrloss - $stakePercentAmount ))
                        fullDay["Day $day"]=-$stakePercentAmount
                        maxMinDay["Day $day"]=$totalWinOrloss
 			(( daysLoss++ ))
                else
                        totalWinOrloss=$(( $totalWinOrloss + $stakePercentAmount ))
                        fullDay["Day $day"]=$stakePercentAmount
                        maxMinDay["Day $day"]=$totalWinOrloss
			(( daysWin++ ))
                fi
        done

echo "Total Won/loss : $totalWinOrLoss"
echo "Winned days $daysWin by $(($daysWin*$stakePercentAmount))" 
echo "Lossed days $daysLoss by  $(($daysLoss*$stakePercentAmount))"
echo "${!maxMinDay[@]} : ${maxMinDay[@]}"

luckyDay=$( printf "%s\n" ${maxMinDay[@]} | sort -nr | head -1 )
unluckyDay=$( printf "%s\n" ${maxMinDay[@]} | sort -nr | tail -1 )

	for data in "${!maxMinDay[@]}"
     	do
		if [[ ${maxMinDay[$data]} -eq $luckyDay ]]
		then
		echo "Lucky Day-" $data
		elif [[ ${maxMinDay[$data]} -eq $unluckyDay ]]
		then
		echo "Unlucky Day-" $data
		fi
     	done

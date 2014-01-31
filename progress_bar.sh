#!/bin/bash

CURRENT_TIME=0
TOTAL_TIME=$1
BAR_SIZE=$2
PERIOD=$(($TOTAL_TIME/$BAR_SIZE))

if [ $PERIOD -eq 0 ]; then
	PERIOD=1
fi

PROGRESS_BAR=""

while [ $CURRENT_TIME -le $TOTAL_TIME ]; do

	if [ $TOTAL_TIME -eq 0 ]; then
		N_CHAR=$(($BAR_SIZE))
	else
		N_CHAR=$(($BAR_SIZE*$CURRENT_TIME/TOTAL_TIME))
	fi
	
	if [ $N_CHAR -ge $BAR_SIZE ]; then
		N_CHAR=$(($BAR_SIZE-1))
	fi

	PROGRESS_BAR=""
	for((i=1;i<=$N_CHAR;i++));do
		PROGRESS_BAR="$PROGRESS_BAR="
	done
	PROGRESS_BAR="$PROGRESS_BAR>"

	TIME_REMAINING=$(($TOTAL_TIME-$CURRENT_TIME))
	TIME_UNIT="seconds"
	if [ $TIME_REMAINING -le 1 ]; then
		TIME_UNIT="second"
	fi
	
	if [ $TOTAL_TIME -eq 0 ]; then
		PERCENTAGE=100
	else
		PERCENTAGE=$((100*$CURRENT_TIME/$TOTAL_TIME))
	fi

	TIME_REMAINING_STRING="($TIME_REMAINING $TIME_UNIT remaining)"

	printf "[%-${BAR_SIZE}s] %3d%% %.25s\r" $PROGRESS_BAR $PERCENTAGE "($TIME_REMAINING $TIME_UNIT remaining) "

	CURRENT_TIME=$(($CURRENT_TIME+$PERIOD))

	sleep $PERIOD
done

echo ""
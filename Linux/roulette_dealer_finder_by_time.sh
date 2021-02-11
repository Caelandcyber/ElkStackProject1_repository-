#! /bin/bash

grep $1 ~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/$3* | grep $2 | awk '{print $1,$2,$5,$6}'

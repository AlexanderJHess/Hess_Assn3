#! /bin/bash
#note that this script operates on the assumption you are in a folder with BTS_data.txt

head BTS_Data.txt
#just to see what the formatting is

head -n 1 BTS_data.txt > bts_header
#for future use in case one wants to return header to subsequent files

tail -n +2 bts_data.txt > bts_justdata
#removes header from file

cut -f 1 BTS_justdata | sort | uniq > bts_data_labels
#cuts everything except the snake id, sorts them, removes non unique id's, and then inputs that to a new file

wc -l bts_data_labels
#checking to make sure i have 424 unique lines in my file.

while read line; do touch file_$line; done < bts_data_labels
#creates individual files for each of my snake id lines in bts_data_labels

counter=0
while read line; do myarray[$counter]=$line; let counter=$((counter+1)); done < bts_data_labels
echo ${myarray[*]}
#sets a counter to 0, than creates an array by reading each line of bts_data_labels, adding them one by one. then echoes the contents of the array for posterity

for i in ${myarray[@]}; do grep "$i" bts_data.txt > file_"$i"; done
#for each element in the array, it greps from bts_data.txt and exports to a file.


echo $(ls file_* | wc -l) files were created!
#Echoes to standard out how many files were created. 


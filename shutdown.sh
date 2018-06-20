#!/bin/sh

echo "entering shutdown.sh"

while [[ $(pidof playground) -ne 0 ]];
do
	pidof playground
	echo $?
	killall playground
done	
cd /nonlinear/text2soled             
./text2soled clear                   
./text2soled 'doing a shutdown!' 0 73           
echo "text written"
        
exit 0

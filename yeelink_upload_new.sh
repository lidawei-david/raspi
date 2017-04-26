namepic=`date +%Y%m%d_%H%M`
raspistill -w 900 -h 1600 -rot 90 -o /home/pi/Documents/raspi_image/${namepic}.jpg
curl --request POST --data-binary @"/home/pi/Documents/raspi_image/${namepic}.jpg" --header "U-ApiKey:d70a4c2821840453f0d39c11017b4cd5" --url http://api.yeelink.net/v1.0/device/350411/sensor/393221/photos

tmp_hmd=`./AdafruitDHT.py 2302 4`
tmp=`echo $tmp_hmd| cut -d " " -f 2`
hmd=`echo $tmp_hmd| cut -d " " -f 4`

# write to json

echo "{" > tmp.txt
echo "\"value\":$tmp" >>tmp.txt
echo "}" >>tmp.txt
echo "{" > hmd.txt
echo "\"value\":$hmd" >>hmd.txt
echo "}" >>hmd.txt

curl --request POST --data-binary @tmp.txt --header "U-ApiKey: d70a4c2821840453f0d39c11017b4cd5" http://api.yeelink.net/v1.0/device/350411/sensor/393222/datapoints
curl --request POST --data-binary @hmd.txt --header "U-ApiKey: d70a4c2821840453f0d39c11017b4cd5" http://api.yeelink.net/v1.0/device/350411/sensor/393224/datapoints
rm *.txt

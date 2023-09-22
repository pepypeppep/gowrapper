mkdir -p modules/$1
mkdir -p modules/$1/model
curl https://pastebin.com/raw/6KR6bthj -nc - --output modules/$1/model/$1.go
sed -i '' "s/LOWERMODULE/$1/g" modules/$1/model/$1.go
VARCAP=$( echo "$1" | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
sed -i '' "s/UPPERMODULE/$VARCAP/g" modules/$1/model/$1.go
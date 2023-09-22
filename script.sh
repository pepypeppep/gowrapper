mkdir -p modules/$1
mkdir -p modules/$1/model
mkdir -p modules/$1/repository
mkdir -p modules/$1/controller
curl https://raw.githubusercontent.com/pepypeppep/gowrapper/main/model.zsn -nc - --output modules/$1/model/$1.go
curl https://raw.githubusercontent.com/pepypeppep/gowrapper/main/repository.zsn -nc - --output modules/$1/repository/$1.go
curl https://raw.githubusercontent.com/pepypeppep/gowrapper/main/controller.zsn -nc - --output modules/$1/controller/$1.go
curl https://raw.githubusercontent.com/pepypeppep/gowrapper/main/routes.zsn -nc - --output modules/$1/routes.go
VARPROJ=$(basename "`pwd`")
sed -i '' "s/PROJECT/$VARPROJ/g" modules/$1/repository/$1.go
sed -i '' "s/PROJECT/$VARPROJ/g" modules/$1/controller/$1.go
sed -i '' "s/PROJECT/$VARPROJ/g" modules/$1/routes.go
sed -i '' "s/LOWERMODULE/$1/g" modules/$1/model/$1.go
sed -i '' "s/LOWERMODULE/$1/g" modules/$1/repository/$1.go
sed -i '' "s/LOWERMODULE/$1/g" modules/$1/controller/$1.go
sed -i '' "s/LOWERMODULE/$1/g" modules/$1/routes.go
VARCAP=$( echo "$1" | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
sed -i '' "s/UPPERMODULE/$VARCAP/g" modules/$1/model/$1.go
sed -i '' "s/UPPERMODULE/$VARCAP/g" modules/$1/repository/$1.go
sed -i '' "s/UPPERMODULE/$VARCAP/g" modules/$1/controller/$1.go
sed -i '' "s/UPPERMODULE/$VARCAP/g" modules/$1/routes.go
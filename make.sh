echo $1
cd $1
elm make '.\src\Main.elm' --output main.js
cd ..
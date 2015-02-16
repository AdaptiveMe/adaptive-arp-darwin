echo Action called: $0 $1 $2


rm -rf $1/App/app*
cd $1
if [ ! "$2" == "clean" ]; then 
   ../tools/osx/apppack/AdaptivePacker -in $1/App.Source -out $1/App -minimize
fi
rm -rf $1/App/*.lock


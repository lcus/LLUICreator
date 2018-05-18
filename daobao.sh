#!/bin/sh

PROJECTPATH="Desktop/LLUICreator"
TARGET="LLUICreator"

if [ -d "${PROJECTPATH}/_product" ]
then
rm -rf "${PROJECTPATH}/_product"
fi
mkdir  "${PROJECTPATH}/_product"

cd "${PROJECTPATH}"
xcodebuild -target ${TARGET} -configuration Release -sdk iphoneos clean build
xcodebuild -target ${TARGET} -configuration Release -sdk iphonesimulator clean build

mv build/Release-iphoneos/LLUICreator.framework/LLUICreator _product/LLUICreator-1
mv build/Release-iphonesimulator/LLUICreator.framework/LLUICreator _product/LLUICreator-2
cp -R build/Release-iphoneos/LLUICreator.framework _product/LLUICreator.framework
cd _product
lipo -create LLUICreator-1 LLUICreator-2 -output LLUICreator
mv LLUICreator LLUICreator.framework/LLUICreator
cp -R LLUICreator.framework /Users/lcus/Desktop/LLUICreator
cd ..
rm -rf _product
rm -rf build



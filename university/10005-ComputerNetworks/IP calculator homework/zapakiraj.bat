@echo off
if not exist "dist" echo Nema dist-a!
if not exist "source" echo Nema source-a!

echo nastaviti?
PAUSE
cd dist
echo generiram zadacu
main zadaca
cd ..
cd ..
"C:\Program Files\7-Zip\7z.exe" a urmDZ.zip .\temp2\*
PAUSE
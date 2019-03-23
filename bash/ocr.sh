FILE_NAME=/tmp/_1
FILE_PATH=/tmp/_1.txt
FILE_PATH2=/tmp/_2.txt
/usr/local/bin/screenshot
tesseract -l eng --dpi 200 $(xclip -selection clipboard -o) $FILE_NAME
sed '/^[[:space:]]*$/d' $FILE_PATH > $FILE_PATH2
cat $FILE_PATH2 | xclip -selection clipboard
notify-send "OCR copied to clipboard"
rm $FILE_NAME
rm $FILE_PATH
rm $FILE_PATH2
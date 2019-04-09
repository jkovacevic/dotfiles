if [ "$#" -ne 1 ]; then echo "Missing CLI argument of discarded file name."; fi;
tmp_file=$HOME/notes/tmp.txt
discard_folder=$HOME/notes/discard
discard_file_path=$discard_folder/$1.txt

if [ -f $discard_file_path ]; then echo "File with the same name ($discard_file_path) already exists!"; exit 1; fi;
cp $tmp_file $discard_file_path
echo "Moved $tmp_file to $discard_file_path"
rm $tmp_file; touch $tmp_file
echo "File $tmp_file had been cleaned"
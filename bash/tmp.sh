log() {
	echo "$1" && notify-send "$1"
}

if [ "$#" -ne 1 ]; then log "Missing CLI argument of scrapped file name."; fi;
tmp_file=$HOME/notes/tmp.txt
tmp_folder=$HOME/notes/tmp
tmp_file_path=$tmp_folder/$1

if [ -f $tmp_file_path ]; then 
	log "File with the same name ($tmp_file_path) already exists!";
	exit 1; 
fi;

cp $tmp_file $tmp_file_path
log "Moved $tmp_file to $tmp_file_path"
rm $tmp_file; touch $tmp_file
log "File $tmp_file had been cleaned"

subl $tmp_file_path
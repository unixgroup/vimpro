#!/bin/bash

###########################################################################
#
# vimup upload script %VERSIONSTAMP%
# 
# Copyright 2009 Helmuth Gronewold
# 
# Known issues:
#  * "~/" not yet supported in project paths. Use absolute paths.
#  * scp mode not implemented yet.
#  * not fully tested ;)
# 
# Last modified: %DATESTAMP% 
# 
###########################################################################


########################## Configuration ##################################
DEBUG=false
PSEP=::		# seperator in plist-file
VPPATH=~/.vimpro
UPLOADFILE=$1


########################### BEGIN SCRIPT ##################################
if test ! -z "$DEBUG"; then
	export DEBUG=$DEBUG
fi

die() {
	echo "FATAL ERROR: $@"
	exit 1;
}

debug() {
	if [ "$DEBUG" = "true" ]; then
		echo $@
	fi
}

debug "Argument is: $UPLOADFILE"

while read project; do
	PPATH=$(echo $project | awk -F $PSEP '{print $1}')
	PNAME=$(echo $project | awk -F $PSEP '{print $2}')

	echo $UPLOADFILE | egrep -q "^$PPATH"
	STATUS=$?
	
	debug "State: $STATUS, '$PNAME', '$PPATH'";

	if [ $STATUS -lt 1 ]; then
		debug "Project found. Skipping."
		break;
	else 
		debug "No match on project path. Resetting variables."
		PPATH=""; 
		PNAME="";
	fi
	debug ""
done  < $VPPATH/plist

test -z "${PNAME}${PPATH}" && die "File is not in any project." || echo "Project: $PNAME"

debug "Reading config"
CONFIGFILE=$VPPATH/${PNAME}.conf
test -f $CONFIGFILE && source $CONFIGFILE || die "Config file '$CONFIGFILE' not found!"

debug "Determining paths and filenames"
LOCALFILE=$(echo $UPLOADFILE | sed -e "s:$LBPATH::g" | sed -e 's:^[/]*::g')
LOCALPATH=$(dirname $LOCALFILE)

debug "Uploading..."

if [ "$UMODE" = "ftp" ]; then 
	NCARGS="-u $USER -p $PASS $HOST $RPATH/$LOCALPATH $LOCALFILE"
	debug "ncftp arguments: '$NCARGS'"
	ncftpput $NCARGS
else
	die "scp mode not implemented yet"
fi

#EOF

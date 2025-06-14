#!/bin/bash 
module load prod_util
set -x

###########################################################################
#
# This is used for rerun by "exdafs_upp_alaska.sh yyyymmddhh"
#
###########################################################################

#--- USE for cronjob ----

cndate=$1

cdate=$cndate
# cdate=$(${NDATE} -1 $cndate)

default_date="cdate_4_cycle"
default_fhr="fhr_4_cycle"

submit=submit_DAFS_AK.sh

for (( ifhr=0; ifhr<=18; ifhr++ )); do
  fhr=$(printf "%02d" $ifhr)
  sed "s/${default_date}/$cdate/" ${submit} > ${submit}-${cdate}_f${fhr} 
  sed  -i "s/${default_fhr}/${fhr}/" ${submit}-${cdate}_f${fhr}
  qsub ${submit}-${cdate}_f${fhr}
done

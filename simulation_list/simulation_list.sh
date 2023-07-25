#!/usr/ksh
sim_dir="$HOME/utility/simulation_log"
sim_file="simulation_total"
history_count=10
database=arak3
set -A ap 31 32 33 34 35 36

if [ ! -d $sim_dir ]
then
    mkdir $sim_dir
fi

for ap_id in ${ap[*]}
do
    txpperl simulation_list.pl $sim_dir/sim_$ap_id $database $ap_id
    txpperl palisim.pl $database $ap_id pali.sim $sim_dir/gwm_$ap_id
done

tag=`expr $history_count - 1`
while [ $tag -ge 0 ]
do  
    if [ -e $sim_dir/$sim_file.old$tag ]
    then
        mv $sim_dir/$sim_file.old$tag $sim_dir/$sim_file.old`expr $tag + 1`
    fi
    tag=`expr $tag - 1`
done

if [ -e $sim_dir/$sim_file ]
then
    mv $sim_dir/$sim_file $sim_dir/$sim_file.old0
fi

for id in ${ap[*]}
do
    cat $sim_dir/sim_$id $sim_dir/gwm_$id >> $sim_dir/$sim_file 
    rm $sim_dir/sim_$id $sim_dir/gwm_$id
done

date >> $sim_dir/$sim_file

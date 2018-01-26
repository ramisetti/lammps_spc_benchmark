printf '#no_of_nodes time_per_100steps speed-up ideal-speed-up\n' > speedup-324k.txt 
flag=0
t1=0
for i in $(ls -v run-324k-*.o*)
do
n=$(echo "$i" | awk -F'-' '{print $3}' | awk -F'.' '{print $1}')
s=$(awk '/Loop time of /{print $4}' $i)
if [ $flag -eq 0 ]; then
t1=$s
flag=1
fi
sr=$(awk -v t1=$t1 -v tN=$s 'BEGIN{print t1/tN}')
printf '%d %f %f %f\n' $n $s $sr $n>> speedup-324k.txt
done

printf '#no_of_nodes time_per_100steps\n' > speedup-1512k.txt 
for i in $(ls -v run-1512k-*.o*)
do
n=$(echo "$i" | awk -F'-' '{print $3}' | awk -F'.' '{print $1}')
s=$(awk '/Loop time of /{print $4}' $i)
if [ $flag -eq 0 ]; then
t1=$s
flag=1
fi
sr=$(awk -v t1=$t1 -v tN=$s 'BEGIN{print t1/tN}')
printf '%d %f %f %f\n' $n $s $sr $n >> speedup-1512k.txt
done

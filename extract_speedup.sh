arr=()
for i in $(ls -v tmp-*-*.o*)
do
    arr+=($(echo $i | cut -f2 -d'-'))
done
all="${arr[@]}"
all=$(echo $all | tr ' ' '\n' | sort -nu)    
cases=($all)

for cas in "${cases[@]}"
do
    printf $cas
    printf '#no_of_nodes time_per_100steps speed-up ideal-speed-up parallel_efficiency\n' > speedup-$cas.txt 
    flag=0
    t1=0
    for i in $(ls -v tmp-$cas-*.o*)
    do
	n=$(echo "$i" | awk -F'-' '{print $3}' | awk -F'.' '{print $1*24}')
	s=$(awk '/Loop time of /{print $4}' $i)
	if [ $flag -eq 0 ]; then
	    t1=$s
	    flag=1
	fi
	printf ' %d' $n
	sr=$(awk -v t1=$t1 -v tN=$s 'BEGIN{print 24*t1/tN}')
	pe=$(awk -v s=$sr -v N=$n 'BEGIN{print s*100/N}')
	printf '%d %f %f %f %f\n' $n $s $sr $n $pe>> speedup-$cas.txt
    done
    printf '\n' 
done  

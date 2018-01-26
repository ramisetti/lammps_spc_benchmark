
#module load lammps/17Nov16

nx=6
ny=4
nz=3
natoms=324k
for i in 1 2 4 8 16; do 
    ncores=$((i*24))
    sed -e "s/NNODES/$i/g" job-template.sh > tmp
    sed -e "s/NCORES/$ncores/g" tmp > run-$natoms-$i.sh
    sed -i -e "s/NXX/$nx/g" run-$natoms-$i.sh
    sed -i -e "s/NYY/$ny/g" run-$natoms-$i.sh
    sed -i -e "s/NZZ/$nz/g" run-$natoms-$i.sh
    sed -i -e "s/NATMS/$natoms/g" run-$natoms-$i.sh
    echo $i $ncores; 
    qsub -V run-$natoms-$i.sh
done

nx=8
ny=7
nz=6
natoms=1512k
echo $natoms
for i in 2 4 8 16 32; do 
    ncores=$((i*24))
    sed -e "s/NNODES/$i/g" job-template.sh > tmp
    sed -e "s/NCORES/$ncores/g" tmp > run-$natoms-$i.sh
    sed -i -e "s/NXX/$nx/g" run-$natoms-$i.sh
    sed -i -e "s/NYY/$ny/g" run-$natoms-$i.sh
    sed -i -e "s/NZZ/$nz/g" run-$natoms-$i.sh
    sed -i -e "s/NATMS/$natoms/g" run-$natoms-$i.sh
    echo $i $ncores; 
    qsub -V run-$natoms-$i.sh
done

rm tmp

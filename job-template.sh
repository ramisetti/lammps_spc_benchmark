#$ -cwd -V
#$ -l h_rt=00:10:00
#$ -l nodes=NNODES

mpirun -np NCORES lmp_mpi -in in.spce -var nx NXX -var ny NYY -var nz NZZ
mv log.lammps log.NATMS.nNNODES

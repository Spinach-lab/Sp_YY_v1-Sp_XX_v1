source ~/miniconda2/etc/profile.d/conda.sh
conda activate maker


mpiexe_ -n 20  maker   maker_opts.ctl maker_bopts.ctl  maker_exe.ctl

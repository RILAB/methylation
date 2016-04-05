ssh -N -f -R 9998:localhost:9998 $SLURM_SUBMIT_HOST
jupyter notebook --port=9998

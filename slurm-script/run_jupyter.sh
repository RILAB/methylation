ssh -N -f -R 9997:localhost:9997 $SLURM_SUBMIT_HOST
jupyter notebook --port=9997

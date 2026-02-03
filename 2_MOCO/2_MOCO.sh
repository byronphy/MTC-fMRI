#!/bin/bash

# unzip .nii.gz mannually
#gunzip tMT_ON.nii.gz
#gunzip tMT_OFF.nii.gz

# Run MATLAB SPM, we need NT.txt here (need editting)
matlab -nodesktop -nosplash -r "motion_correct_batch"

# Plot the motion (need editting)
gnuplot "2_gnuplot_motion.txt"

cd /Func

# demean
1d_tool.py -overwrite \
	-infile rp_tMT_ON.txt \
	-demean \
	-write MT_ON_motion_demean.1D

1d_tool.py -overwrite \
	-infile rp_tMT_OFF.txt \
	-demean \
	-write MT_OFF_motion_demean.1D

# 1st-order derivative
1d_tool.py -overwrite \
    -infile rp_tMT_ON.txt \
    -derivative -demean \
    -write MT_ON_motion_deriv.1D

1d_tool.py -overwrite \
    -infile rp_tMT_OFF.txt \
    -derivative -demean \
    -write MT_OFF_motion_deriv.1D

# 12-parameter motion regressor
1dcat MT_ON_motion_demean.1D MT_ON_motion_deriv.1D > MT_ON_motion_12.1D
1dcat MT_OFF_motion_demean.1D MT_OFF_motion_deriv.1D > MT_OFF_motion_12.1D

# Motion censor
1d_tool.py -overwrite \
    -infile rp_tMT_ON.txt \
    -censor_motion 0.4 MT_ON_motion \
    -censor_prev_TR

1d_tool.py -overwrite \
    -infile rp_tMT_OFF.txt \
    -censor_motion 0.4 MT_OFF_motion \
    -censor_prev_TR

1deval -a MT_ON_motion_censor.1D -b MT_OFF_motion_censor.1D -expr 'a*b' \
	> MT_boco_motion_censor.1D



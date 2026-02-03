#!/bin/bash

cd /Func


MASK='HRF_M1R_27_mask'

# ====Extraction profiles (mean value, STDEV, and number of voxels)====

3dROIstats -mask ${MASK}.nii -quiet -nzmean -sigma -nzvoxels HRF_STATS_nrtMT_ON.nii > HRF_temp.1D
awk '{print $2, $3, $4}' HRF_temp.1D > ${MASK}_ON.dat
rm -f HRF_temp.1D

3dROIstats -mask ${MASK}.nii -quiet -nzmean -sigma -nzvoxels HRF_STATS_nrtMT_OFF.nii > HRF_temp.1D
awk '{print $2, $3, $4}' HRF_temp.1D > ${MASK}_OFF.dat
rm -f HRF_temp.1D

# Plot
gnuplot -e "my_title='${MASK}'; my_ylabel='Signal change (%)'; ON_data='${MASK}_ON.dat'; OFF_data='${MASK}_OFF.dat'" gnuplot_HRF.txt


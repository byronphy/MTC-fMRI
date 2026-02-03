#!/bin/bash

cd /Func

# ON, OFF, boco
TYPE='boco'
LAYER_MASK='rim_V1R_13_layers'

FUNC_NII='nrtMT_'${TYPE}'.nii'
MEAN_NII='rtMT_'${TYPE}'_mean.nii'

# output file
LAYER_MEAN=${LAYER_MASK}'_mean_nrtMT_'${TYPE}'.dat'
LAYER_BETA_PERCENT=${LAYER_MASK}'_beta_STATS_nrtMT_'${TYPE}'.dat'
LAYER_T_STATS=${LAYER_MASK}'_t_STATS_nrtMT_'${TYPE}'.dat'
LAYER_Z_STATS=${LAYER_MASK}'_z_STATS_nrtMT_'${TYPE}'.dat'

# ====Extraction profiles (mean value, STDEV, and number of voxels)====
# Do once, MTR
3dROIstats -mask ${LAYER_MASK}.nii -quiet -nzmean -sigma -nzvoxels us_rtMTR_mean.nii > layer_row_tem.1D
1dtranspose layer_row_tem.1D | xargs -n 4 > layer_tem.txt
awk '{print $2, $3, $4}' layer_tem.txt > ${LAYER_MASK}'_rtMTR_mean.dat'

# mean
#3dROIstats -mask ${LAYER_MASK}.nii -quiet -nzmean -sigma -nzvoxels us_${MEAN_NII} > layer_row_tem.1D
#1dtranspose layer_row_tem.1D | xargs -n 4 > layer_tem.txt
#awk '{print $2, $3, $4}' layer_tem.txt > ${LAYER_MEAN}

# beta percent
3dROIstats -mask ${LAYER_MASK}.nii -quiet -nzmean -sigma -nzvoxels us_beta_STATS_${FUNC_NII} > layer_row_tem.1D
1dtranspose layer_row_tem.1D | xargs -n 4 > layer_tem.txt
awk '{print $2, $3, $4}' layer_tem.txt > ${LAYER_BETA_PERCENT}

# t stats
#3dROIstats -mask ${LAYER_MASK}.nii -quiet -nzmean -sigma -nzvoxels us_t_STATS_${FUNC_NII} > layer_row_tem.1D
#1dtranspose layer_row_tem.1D | xargs -n 4 > layer_tem.txt
#awk '{print $2, $3, $4}' layer_tem.txt > ${LAYER_T_STATS}

# z stats
#3dROIstats -mask ${LAYER_MASK}.nii -quiet -nzmean -sigma -nzvoxels us_z_STATS_${FUNC_NII} > layer_row_tem.1D
#1dtranspose layer_row_tem.1D | xargs -n 4 > layer_tem.txt
#awk '{print $2, $3, $4}' layer_tem.txt > ${LAYER_Z_STATS}

rm -f layer_row_tem.1D layer_tem.txt


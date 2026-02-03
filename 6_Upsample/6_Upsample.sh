#!/bin/bash

cd /Func

# input: ON, OFF, boco
TYPE='boco'

FUNC_NII='nrtMT_'${TYPE}'.nii'
MEAN_NII='rtMT_'${TYPE}'_mean.nii'

# 3-fold upsampling in-plane
read dx dy dz <<< $(3dinfo -ad3 ${MEAN_NII})
sdx=$(echo "$dx / 3" | bc -l)
sdy=$(echo "$dy / 3" | bc -l)
sdz=$(echo "$dz / 1" | bc -l) 

# Do once
3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Cu -overwrite -prefix us_rT1.nii -input rT1.nii
3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Cu -overwrite -prefix us_rtMTR_mean.nii -input rtMTR_mean.nii

3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Cu -overwrite -prefix us_${MEAN_NII} -input ${MEAN_NII}
3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Cu -overwrite -prefix us_beta_STATS_${FUNC_NII} -input beta_STATS_${FUNC_NII}
#3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Li -overwrite -prefix us_t_STATS_${FUNC_NII} -input t_STATS_${FUNC_NII}
#3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Li -overwrite -prefix us_z_STATS_${FUNC_NII} -input z_STATS_${FUNC_NII}




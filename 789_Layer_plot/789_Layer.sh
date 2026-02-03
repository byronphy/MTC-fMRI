#!/bin/bash

cd /Func

LAYER_MASK0='rim_V1R_14'

# === 7
LN_GROW_LAYERS -rim ${LAYER_MASK0}.nii -N 21 -vinc 40

LAYER_MASK=${LAYER_MASK0}'_layers'
# === 8
# MTR
3dROIstats -mask ${LAYER_MASK}.nii -quiet -nzmean -sigma -nzvoxels us_rtMTR_mean.nii > layer_row_tem.1D
1dtranspose layer_row_tem.1D | xargs -n 4 > layer_tem.txt
awk '{print $2, $3, $4}' layer_tem.txt > ${LAYER_MASK}'_rtMTR_mean.dat'

# ON beta percent
3dROIstats -mask ${LAYER_MASK}.nii -quiet -nzmean -sigma -nzvoxels us_beta_STATS_nrtMT_ON.nii > layer_row_tem.1D
1dtranspose layer_row_tem.1D | xargs -n 4 > layer_tem.txt
awk '{print $2, $3, $4}' layer_tem.txt > ${LAYER_MASK}'_beta_STATS_nrtMT_ON.dat'

# OFF beta percent
3dROIstats -mask ${LAYER_MASK}.nii -quiet -nzmean -sigma -nzvoxels us_beta_STATS_nrtMT_OFF.nii > layer_row_tem.1D
1dtranspose layer_row_tem.1D | xargs -n 4 > layer_tem.txt
awk '{print $2, $3, $4}' layer_tem.txt > ${LAYER_MASK}'_beta_STATS_nrtMT_OFF.dat'

# boco beta percent
3dROIstats -mask ${LAYER_MASK}.nii -quiet -nzmean -sigma -nzvoxels us_beta_STATS_nrtMT_boco.nii > layer_row_tem.1D
1dtranspose layer_row_tem.1D | xargs -n 4 > layer_tem.txt
awk '{print $2, $3, $4}' layer_tem.txt > ${LAYER_MASK}'_beta_STATS_nrtMT_boco.dat'

rm -f layer_row_tem.1D layer_tem.txt

# === 9
gnuplot -e "my_title='${LAYER_MASK}_beta_STATS_profile'; my_ylabel='Signal change (%)'; MT_OFF='${LAYER_MASK}_beta_STATS_nrtMT_OFF.dat'; MT_ON='${LAYER_MASK}_beta_STATS_nrtMT_ON.dat'" gnuplot_layers_ON_OFF.txt

gnuplot -e "my_title='${LAYER_MASK}_beta_STATS_boco_profile'; my_ylabel='Signal change (%)'; MT_boco='${LAYER_MASK}_beta_STATS_nrtMT_boco.dat'" gnuplot_layers_boco.txt

gnuplot -e "my_title='${LAYER_MASK}_rtMTR_mean_profile'; my_ylabel='MTR'; MT_boco='${LAYER_MASK}_rtMTR_mean.dat'" gnuplot_layers_boco.txt



#!/bin/bash

cd /Func

# ON or OFF
TYPE='OFF'

FUNC_NII='nrtMT_'${TYPE}'.nii'
CENSOR_1D='MT_'${TYPE}'_motion_censor.1D'
MOTION12_1D='MT_'${TYPE}'_motion_12.1D'
MASK_NII='mask_rtMT_OFF.nii'

# ====GLM for beta, t, z====
3dDeconvolve -overwrite -jobs 16 -polort a -input ${FUNC_NII} \
	-mask ${MASK_NII} \
	-TR_times 2.38 \
	-censor ${CENSOR_1D} \
	-num_stimts 2 \
	\
	-stim_times 1 '1D: 30 90 150 210 270' 'UBLOCK(30,1)' \
	-stim_label 1 Task \
	\
	-stim_file 2 ${MOTION12_1D} \
   	-stim_base 2 \
    	-stim_label 2 Motion \
	\
	-tout \
	-x1D MODEL_UBLOCK_${FUNC_NII} \
	-bucket STATS_UBLOCK_${FUNC_NII}

echo "Succees in GLM for beta, percent signal change, t, z."

# beta 
3dbucket -prefix beta_STATS_${FUNC_NII} STATS_UBLOCK_${FUNC_NII}'[Task#0_Coef]' -overwrite

# t-map
3dbucket -prefix t_STATS_${FUNC_NII} STATS_UBLOCK_${FUNC_NII}'[Task#0_Tstat]' -overwrite

# z-score
3dmerge -1zscore -prefix z_STATS_${FUNC_NII} t_STATS_${FUNC_NII} -overwrite


# ====GLM for HRF==== 3 volume in advance
3dDeconvolve -overwrite -jobs 16 -polort a -input ${FUNC_NII} \
	-mask ${MASK_NII} \
	-TR_times 2.38 \
	-censor ${CENSOR_1D} \
	-num_stimts 2 \
	\
	-stim_times 1 '1D: 30 90 150 210 270' 'TENT(-7.14,47.6,24)' \
	-stim_label 1 Task \
	\
	-stim_file 2 ${MOTION12_1D} \
   	-stim_base 2 \
    	-stim_label 2 Motion \
	\
	-fout \
	-x1D MODEL_TENT_${FUNC_NII} \
	-iresp 1 HRF_STATS_${FUNC_NII} \
	-bucket STATS_TENT_${FUNC_NII}

echo "Succees in GLM for HRF."



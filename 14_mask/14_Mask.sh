#!/bin/bash

cd /Func

# input
MTON="MT_ON.nii.gz"
MTOFF="MT_OFF.nii.gz"
IPE_MTON="IPE_MT_ON.nii.gz"
IPE_MTOFF="IPE_MT_OFF.nii.gz"
ACQPARAMS="$PWD/1_Topup/acqparams.txt"

3dcalc -overwrite -a rtMT_ON_mean.nii -b mask_rtMT_OFF.nii -expr 'a*b' -prefix rtMT_ON_mean_mask.nii
3dcalc -overwrite -a rtMT_OFF_mean.nii -b mask_rtMT_OFF.nii -expr 'a*b' -prefix rtMT_OFF_mean_mask.nii





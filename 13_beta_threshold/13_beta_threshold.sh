#!/bin/bash

cd /Func



3dcalc -a beta_STATS_nrtMT_boco.nii -b z_STATS_nrtMT_boco.nii -expr 'a * step(abs(b) - 3.29)' -prefix beta_thres_nrtMT_boco.nii -overwrite
3dcalc -a beta_STATS_nrtMT_ON.nii -b z_STATS_nrtMT_ON.nii -expr 'a * step(abs(b) - 3.29)' -prefix beta_thres_nrtMT_ON.nii -overwrite
3dcalc -a beta_STATS_nrtMT_OFF.nii -b z_STATS_nrtMT_OFF.nii -expr 'a * step(abs(b) - 3.29)' -prefix beta_thres_nrtMT_OFF.nii -overwrite



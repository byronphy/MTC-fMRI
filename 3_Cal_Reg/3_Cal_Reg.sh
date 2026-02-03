#!/bin/bash

cd /Func

3drefit -TR 2.38 rtMT_ON.nii
3drefit -TR 2.38 rtMT_OFF.nii

3dcalc -overwrite -a rtMT_ON.nii -b rtMT_OFF.nii -expr 'a/b' -prefix rtMT_boco.nii

3dTstat -cvarinv -overwrite -prefix rtMT_ON_tSNR.nii rtMT_ON.nii
3dTstat -cvarinv -overwrite -prefix rtMT_OFF_tSNR.nii rtMT_OFF.nii
3dTstat -cvarinv -overwrite -prefix rtMT_boco_tSNR.nii rtMT_boco.nii

3dTstat -mean -overwrite -prefix rtMT_ON_mean.nii rtMT_ON.nii
3dTstat -mean -overwrite -prefix rtMT_OFF_mean.nii rtMT_OFF.nii
3dTstat -mean -overwrite -prefix rtMT_boco_mean.nii rtMT_boco.nii

3dcalc -overwrite -a rtMT_ON_mean.nii -b rtMT_OFF_mean.nii -expr '(b-a)/b' -prefix rtMTR_mean.nii

3dcalc -overwrite -a rtMT_ON.nii -b rtMT_ON_mean.nii -expr 'a/b*100' -prefix nrtMT_ON.nii
3dcalc -overwrite -a rtMT_OFF.nii -b rtMT_OFF_mean.nii -expr 'a/b*100' -prefix nrtMT_OFF.nii
3dcalc -overwrite -a rtMT_boco.nii -b rtMT_boco_mean.nii -expr 'a/b*100' -prefix nrtMT_boco.nii

3dAutomask -overwrite -prefix mask_rtMT_OFF.nii rtMT_OFF.nii

cd $PWD/3_Cal_Reg

# Register T1 to rtMT_OFF_mean.nii , we need T1.nii here (need editting)
matlab -nodesktop -nosplash -r "registerT1_batch"

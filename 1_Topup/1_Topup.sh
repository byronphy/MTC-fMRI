#!/bin/bash

cd /Func

# input
MTON="MT_ON.nii.gz"
MTOFF="MT_OFF.nii.gz"
IPE_MTON="IPE_MT_ON.nii.gz"
IPE_MTOFF="IPE_MT_OFF.nii.gz"
ACQPARAMS="$PWD/1_Topup/acqparams.txt"

# output
NT_txt_path="NT.txt"
MTON_output="tMT_ON.nii.gz"
MTOFF_output="tMT_OFF.nii.gz"

# Cut
# Drop the [0,1,2,3], copy the [4,5,6,7] in the front
NumVol=`3dinfo -nv ${MTON}`
3dTcat -overwrite -prefix ${MTON} ${MTON}[4..7] ${MTON}[4..`expr $NumVol - 1`]
3dTcat -overwrite -prefix ${MTOFF} ${MTOFF}[4..7] ${MTOFF}[4..`expr $NumVol - 1`]

# Save the TR number
3dinfo -nt ${MTON} >> ${NT_txt_path}
3dinfo -nt ${MTOFF} >> ${NT_txt_path}

# AP: choose middle timepoint
fslroi ${MTOFF} AP_ref.nii 64 1
# PA: average
fslmaths ${IPE_MTOFF} -Tmean PA_ref.nii
# Merge
fslmerge -t AP_PA_for_topup.nii AP_ref.nii PA_ref.nii

# topup
topup --imain=AP_PA_for_topup.nii \
	--datain=${ACQPARAMS} \
	--config=b02b0.cnf \
	--out=topup_b0 \
	--iout=topup_b0_unwarped

# Apply
applytopup --imain=${MTON} \
	--datain=${ACQPARAMS} \
	--inindex=1 \
	--topup=topup_b0 \
	--out=${MTON_output} \
	--method=jac

applytopup --imain=${MTOFF} \
	--datain=${ACQPARAMS} \
	--inindex=1 \
	--topup=topup_b0 \
	--out=${MTOFF_output} \
	--method=jac






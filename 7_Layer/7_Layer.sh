#!/bin/bash

cd /Func

LAYER_MASK='rim_V1R_13'

#gunzip ${LAYER_MASK}.nii.gz

LN_GROW_LAYERS -rim ${LAYER_MASK}.nii -N 21 -vinc 40



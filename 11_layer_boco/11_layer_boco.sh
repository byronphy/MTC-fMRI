#!/bin/bash

cd /Func


LAYER_MASK='rim_V1L_10_layers'

MT_OFF=${LAYER_MASK}'_beta_STATS_nrtMT_OFF.dat'
MT_ON=${LAYER_MASK}'_beta_STATS_nrtMT_ON.dat'

paste ${MT_ON} ${MT_OFF} | awk '{print $1 / $4}' > layer_newboco.dat

# Plot
gnuplot -e "my_title='${LAYER_MASK}_beta_newboco_profile'; my_ylabel='Signal change ratio'; my_data='layer_newboco.dat'" gnuplot_newboco.txt

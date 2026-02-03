#!/bin/bash

cd /Func

LAYER_MASK='rim_V1R_13_layers'

# ON and OFF
#gnuplot -e "my_title='${LAYER_MASK}_mean_profile'; my_ylabel='mean'; MT_OFF='${LAYER_MASK}_mean_nrtMT_OFF.dat'; MT_ON='${LAYER_MASK}_mean_nrtMT_ON.dat'" gnuplot_layers_ON_OFF.txt

gnuplot -e "my_title='${LAYER_MASK}_beta_STATS_profile'; my_ylabel='Signal change (%)'; MT_OFF='${LAYER_MASK}_beta_STATS_nrtMT_OFF.dat'; MT_ON='${LAYER_MASK}_beta_STATS_nrtMT_ON.dat'" gnuplot_layers_ON_OFF.txt

#gnuplot -e "my_title='${LAYER_MASK}_t_STATS_profile'; my_ylabel='t value'; MT_OFF='${LAYER_MASK}_t_STATS_nrtMT_OFF.dat'; MT_ON='${LAYER_MASK}_t_STATS_nrtMT_ON.dat'" gnuplot_layers_ON_OFF.txt

#gnuplot -e "my_title='${LAYER_MASK}_z_STATS_profile'; my_ylabel='z score'; MT_OFF='${LAYER_MASK}_z_STATS_nrtMT_OFF.dat'; MT_ON='${LAYER_MASK}_z_STATS_nrtMT_ON.dat'" gnuplot_layers_ON_OFF.txt

# boco
#gnuplot -e "my_title='${LAYER_MASK}_mean_boco_profile'; my_ylabel='mean'; MT_boco='${LAYER_MASK}_mean_nrtMT_boco.dat'" gnuplot_layers_boco.txt

gnuplot -e "my_title='${LAYER_MASK}_beta_STATS_boco_profile'; my_ylabel='Signal change (%)'; MT_boco='${LAYER_MASK}_beta_STATS_nrtMT_boco.dat'" gnuplot_layers_boco.txt

#gnuplot -e "my_title='${LAYER_MASK}_t_STATS_boco_profile'; my_ylabel='t value'; MT_boco='${LAYER_MASK}_t_STATS_nrtMT_boco.dat';" gnuplot_layers_boco.txt

#gnuplot -e "my_title='${LAYER_MASK}_z_STATS_boco_profile'; my_ylabel='z score'; MT_boco='${LAYER_MASK}_z_STATS_nrtMT_boco.dat';" gnuplot_layers_boco.txt

gnuplot -e "my_title='${LAYER_MASK}_rtMTR_mean_profile'; my_ylabel='MTR'; MT_boco='${LAYER_MASK}_rtMTR_mean.dat'" gnuplot_layers_boco.txt





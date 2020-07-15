## Visualizing_transfer_learning with Lucid:

* Run the_script.sh for training/generating pb files for visualization/visualize.


* Set the correct parameters in the_script.sh, check description below and comments for more understanding.

# Links for the 3 used datasets:

* celeba dataset : https://github.com/robisz1911/celeba_dataset


* animals dataset : https://github.com/robisz1911/LUCID_RESULTS/tree/master/DATASETS/animals


* flowers17 dataset : https://github.com/robisz1911/LUCID_RESULTS/tree/master/DATASETS/flowers17

# Generating neuron catalog for the whole network(before/after pairs for every channels):

**parameter setup:** <br/>
*training="True" <br/>
*pb_gen="True" <br/>
*save_checkpoints="True"   (this way you can create temporal visualizations later, turn off if you don't want to) <br/>
*visualize_all_steps="False" <br/>
*visualize_only_first_and_last_epoch="True" <br/>
*input="neuron_list_for_neuron_catalog.txt" <br/>

# Generating temporal visualizations for the listed objects:

**parameter setup:** <br/>
*training="True" <br/>
*pb_gen="True" <br/>
*save_checkpoints="True" <br/>
*visualize_all_steps="True" <br/>
*visualize_only_first_and_last_epoch="False" <br/>
*input="layers_neuron_list.txt"    (list the objects here, in the same format)

# Training only:

**parameter setup:** <br/>
*training="True" <br/>
*pb_gen="True"               (creating pb files which is the input for the visualizations, you can do it anytime later before visualizations) <br/>
*save_checkpoints="True"     (this way you can create temporal visualizations later, turn off if you don't) <br/>
*visualize_all_steps="False" <br/>
*visualize_only_first_and_last_epoch="False" <br/>

**the order is: training->pb_generation->visualization** <br/>
**if you have a training already, with generated pb files, set training and pb_gen to "False"**

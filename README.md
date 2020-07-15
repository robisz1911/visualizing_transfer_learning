## Visualizing_transfer_learning with Lucid:

* Run the_script.sh for training/generating pb files for visualization/visualize.


* Set the correct parameters in the_script.sh, check description below and comments for more understanding.

# Links for the 3 used datasets:

* celeba dataset : https://github.com/robisz1911/celeba_dataset


* animals dataset : https://github.com/robisz1911/LUCID_RESULTS/tree/master/DATASETS/animals


* flowers17 dataset : https://github.com/robisz1911/LUCID_RESULTS/tree/master/DATASETS/flowers17

# Generating neuron catalog for the whole network(before/after pairs for every channels):

**parameter setup:**
*training="True"
*pb_gen="True"
*save_checkpoints="True"   (this way you can create temporal visualizations later, turn off if you don't)
*visualize_all_steps="False"
*visualize_only_first_and_last_epoch="True"
*input="neuron_list_for_neuron_catalog.txt"

# Generating temporal visualizations for the listed objects:

**parameter setup:**
*training="True"
*pb_gen="True"
*save_checkpoints="True"
*visualize_all_steps="True"
*visualize_only_first_and_last_epoch="False"
*input="layers_neuron_list.txt"    (list the objects here, in the same format)

# Training only:

**parameter setup:**
*training="True"
*pb_gen="True"               (creating pb files which is the input for the visualizations, you can do it anytime later before visualizations)
*save_checkpoints="True"     (this way you can create temporal visualizations later, turn off if you don't)
*visualize_all_steps="False"
*visualize_only_first_and_last_epoch="False"

**the order is: training->pb_generation->visualization**
**if you have a training already, with generated pb files, set training and pb_gen to "False"**

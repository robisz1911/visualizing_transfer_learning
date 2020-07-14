#!/bin/bash

training="True" if # if you wanna to visualize only, turn False   training will generate a file, names saved_epochs_list.txt, epoch's number is listed here if there were ckpt saving. At the begging of the training we save more ckpt, and as time goes, less and less ckpt is saved
pb_gen="True" # generating ckpt -> pb whitch is the input for the visualizations
save_checkpoints="True" # if True: save ckpt file after "every" epoch False: save only the first and last ckpt file
visualize_all_steps="True" # if save_checkpoints are true, or previously runned, it 'll visualize each neuron in "layer_neuron_list" after "every" epoch where checkpoint were saved
visualize_only_the_last_epoch="False" # visualize neurons from " layer_neuron_list" from the pb file generated at the last epoch


nb_epoch=10
dataset=celeba  # can be either celeba/flowers17/animals
steps_per_epoch=10 # number of training steps in each epoch
batch_size=10
cutoff=0
top_node="dense_1/Sigmoid" #dense_1/Sigmoid if dataset=celeba | dense_1/Softmax if dataset=flowers17 or animals
do_save_model="True"
do_load_model="False"
input="layers_neuron_list.txt" # neurons listed here 'll be visualized
working_directory=test_celeba # pb files and images 'll be saved in the folder


##### TRAINING #####
if [ $training == True ]
then
    echo "TRAINING"
    if [ $dataset == celeba ]
    then
        echo "celeba"
        trainer=train_celeba_2.0.py
    else
        echo "not celeba"
        trainer=train_2.0.py
    fi
fi

mkdir $working_directory

python $trainer --do_load_model=$do_load_model --do_save_model=$do_save_model --top_node=$top_node --save_checkpoints=$save_checkpoints --batch_size=$batch_size --nb_epoch=$nb_epoch --dataset=$dataset --cutoff=$cutoff --steps_per_epoch=$steps_per_epoch

echo "TRAINING DONE"
cd .
#mv acc.txt $working_directory/

##### GENERATE PB FILES #####

if [ $pb_gen == "True" ]
then
    echo "PB GENERATION"
    while IFS= read line
    do

        for i in $(echo $line | sed "s/,/ /g")
        do
            python create_pb.py --epoch=$i
            rm ${i}model.ckpt ${i}model.ckpt.meta
        done
    done < "saved_epochs_list.txt"

fi

##### VISUALIZATION #####
echo "VISUALIZATION"



while IFS= read -r line
do
    #echo $line
#read txt line by line
#each line is a space separated string
#example line:    "layer 1,2,3,4,5"
#separate by space into 2 variable
    vars=( $line )
    layer=${vars[0]}
    neuron_list=${vars[1]}
#iterate over the second variable below(neuron indexes)

    if [ $visualize_all_steps == True ]
    then
        for neuron_index in $(echo $neuron_list | sed "s/,/ /g")
        do
            #echo "$layer"
            #echo "$i"
            #for each layer name and neuron index
            #iterate over the .pb files
            while IFS= read line
            do
                for i in $(echo $line | sed "s/,/ /g")
                do
                    python vis_neuron.py --MODEL_PATH=$i.pb --LAYER=$layer --NEURON_INDEX=$neuron_index
                done
            done < "saved_epochs_list.txt"
        echo "merge.py-start"
        python merge.py --column=1 --name=merged_steps${layer////-}$neuron_index
        echo "merge.py-end"
        mv merged_steps${layer////-}$neuron_index.png $working_directory/
        rm *.png
        done



    elif [ $visualize_only_the_last_epoch == "True" ]
    then
        for neuron_index in $(echo $neuron_list | sed "s/,/ /g")
        do
            python vis_neuron.py --MODEL_PATH=0.pb --LAYER=$layer --NEURON_INDEX=$neuron_index
            python vis_neuron.py --MODEL_PATH=80.pb --LAYER=$layer --NEURON_INDEX=$neuron_index
            echo "merge.py-start"
            python merge.py --column=1 --name=merged_steps${layer////-}$neuron_index
            mv merged_steps${layer////-}$neuron_index.png $working_directory/
            echo "merge.py-end"
            rm *.png
        done
    fi
    

done < "$input"

#!/bin/bash
#
# little wrapper script to carry out 
# tree cnn simulation 


for ((ii=1; ii<=5; ii++)) 
do

	# run cardinal tasks, blocked, north->south
	python main.py --exp_boundary cardinal --exp_curriculum blocked --exp_rewards pp --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum blocked --exp_rewards mm --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum blocked --exp_rewards pm --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum blocked --exp_rewards mp --exp_taskorder ns --exp_runID $ii &&

	# run cardinal tasks, blocked, south->north
	python main.py --exp_boundary cardinal --exp_curriculum blocked --exp_rewards pp --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum blocked --exp_rewards mm --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum blocked --exp_rewards pm --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum blocked --exp_rewards mp --exp_taskorder sn --exp_runID $ii &&

	# in interleaved, task order doesn't matter. but I want equal numbers of runs
	# run cardinal tasks, interleaved, north->south
	python main.py --exp_boundary cardinal --exp_curriculum interleaved --exp_rewards pp --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum interleaved --exp_rewards mm --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum interleaved --exp_rewards pm --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum interleaved --exp_rewards mp --exp_taskorder ns --exp_runID $ii &&

	# run cardinal tasks, interleaved, south->north
	python main.py --exp_boundary cardinal --exp_curriculum interleaved --exp_rewards pp --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum interleaved --exp_rewards mm --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum interleaved --exp_rewards pm --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary cardinal --exp_curriculum interleaved --exp_rewards mp --exp_taskorder sn --exp_runID $ii &&


	# run diagonal tasks, blocked, north->south
	python main.py --exp_boundary diagonal --exp_curriculum blocked --exp_rewards pp --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum blocked --exp_rewards mm --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum blocked --exp_rewards pm --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum blocked --exp_rewards mp --exp_taskorder ns --exp_runID $ii &&

	# run diagonal tasks, blocked, south->north
	python main.py --exp_boundary diagonal --exp_curriculum blocked --exp_rewards pp --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum blocked --exp_rewards mm --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum blocked --exp_rewards pm --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum blocked --exp_rewards mp --exp_taskorder sn --exp_runID $ii &&

	# in interleaved, task order doesn't matter. but I want equal numbers of runs
	# run diagonal tasks, interleaved, north->south
	python main.py --exp_boundary diagonal --exp_curriculum interleaved --exp_rewards pp --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum interleaved --exp_rewards mm --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum interleaved --exp_rewards pm --exp_taskorder ns --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum interleaved --exp_rewards mp --exp_taskorder ns --exp_runID $ii &&

	# run diagonal tasks, interleaved, south->north
	python main.py --exp_boundary diagonal --exp_curriculum interleaved --exp_rewards pp --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum interleaved --exp_rewards mm --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum interleaved --exp_rewards pm --exp_taskorder sn --exp_runID $ii &&
	python main.py --exp_boundary diagonal --exp_curriculum interleaved --exp_rewards mp --exp_taskorder sn --exp_runID $ii 



done
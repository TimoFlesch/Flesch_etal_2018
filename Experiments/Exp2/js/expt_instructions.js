
/* **************************************************************************************

Shows instructions via html injection
(c) Timo Flesch, 2016 [timo.flesch@gmail.com]


************************************************************************************** */

var startedinstructions  = false;
var finishedinstructions = false;
var pageIDX      = 0;
var inStruct     = [];
inStruct.cap     = []; // caption/headline
inStruct.txt     = []; // content
inStruct.img     = []; // illustration

//setInstructions(); 

function setInstructions(taskID) {
/*
	here I define my instructions
*/
	pageIDX      = 0;
	if(taskID=='dissimrating_pre') {

		inStruct.cap     = []; // caption/headline
		inStruct.txt     = []; // content
		inStruct.img     = []; // illustration
		// welcome (suboptimal, as I define this also in the html)
		inStruct.txt[0]     = "<br> You'll now receive detailed instructions for the next task. <br> Please use the buttons below to navigate through these instructions."
		inStruct.img[0]     = [];

		// whereami
		inStruct.txt[1]     = "You're now in the PRE phase of the experiment."
		inStruct.img[1]     = 'instructions/taskstructure_pre.png'

		// basics
		inStruct.txt[2]     = "In this part of the experiment, you'll have to arrange trees on the screen such that the distances between them reflect how dissimilar they appear to be from each other. <br><br> At the beginning of each trial, you'll see a grey arena with 25 trees that are arranged in a circle.<br>"
	    inStruct.img[2]     =  "instructions/canvas.png";
		
		// drag and drop
	    inStruct.txt[3]     = "If you click with the left mouse button on a tree and hold down the button, you're able to move the tree around within the grey area. <br><br> Release the button to confirm your selection.<br><br> The animation below illustrates how this looks like in practice."
	    inStruct.img[3]     = "instructions/dragndrop.gif"

	    // dissim ratings
	    inStruct.txt[4]     = "If you think that two trees are quite similar to each other, move them close together. If they appear to be dissimilar, make sure they're far apart from each other.<br> You'll have to do this for <b>ALL</b> 25 trees before you move on. That is, in your final arrangement, the distance between any two trees should reflect the subjective dissimilarity. <br> Please have a look at the example below for clarification."
	    inStruct.img[4]     = "instructions/arrange.gif"

	    // next
	    inStruct.txt[5]    = "Once you're satisfied with the arrangement, press the green <b>Next Trial</b> button at the bottom of the page. <br>You'll then proceed with the next trial, where you'll be asked to perform the same task with a slightly different set of trees. <br> Please note that the arrangement in the example below is arbitrary and doesn't contain any useful information for you to complete the task :)"
	    inStruct.img[5]    = "instructions/proceed.gif" 

	    // sunnary
	    inStruct.txt[6]    = "<b>Summary </b><br><br>1. On each trial, you'll see 25 trees that are arranged in a circle. <br><br>2. Your task is to change the arrangement until the distances between all 25 trees reflects the pairwise dissimilarities.<br><br>3. Once you're satisfied with your arrangement, you'll click the next trial button to proceed with a new set of trees.<br><br><br> <b>There will be six trials in total and it shouldn't take you longer than 15 minutes to finish this first phase of the experiment.<br>If you're ready to begin with the experiment, press the red start button below!</b>";

	    inStruct.img[6]    = [];
	}
	else if (taskID=='treetask_main') {
	
		inStruct.cap     = []; // caption/headline
		inStruct.txt     = []; // content
		inStruct.img     = []; // illustration
		// welcome (suboptimal, as I define this also in the html)
		inStruct.txt[0]     = "<br> You'll now receive detailed instructions for the next task. <br> Please use the buttons below to navigate through these instructions."
		inStruct.img[0]     = [];


		// whereami
		inStruct.txt[1]     = "You're now in the MAIN phase of the experiment."
		inStruct.img[1]     = 'instructions/taskstructure_main.png'

		// north orchard
		inStruct.txt[2]     = "Imagine that you are a gardener. <br> You own two orchards.<br>The first one is the <b>north orchard</b> <br>"
	    inStruct.img[2]     =  "instructions/instr_orchard_north.png";
		
	    // south orchard
	    inStruct.txt[3]     = "And the second one is the <b>south orchard</b> <br>"
	    inStruct.img[3]     =  "instructions/instr_orchard_south.png";
		
		// what to do
		inStruct.txt[4]     = "<b>You would like to plant some trees in those gardens.</b><br><br>However, you don't know yet which trees grow best in those gardens.<br>The only thing you know is that you need different types of trees for both gardens.<br><br><b>Your task is to figure out which trees grow in each garden and to plant exactly those trees in order to maximize your reward."
		inStruct.img[4]    = "";

		// trial - context
		inStruct.txt[5]     = "Each trial begins with an image of the garden you're currently in."
		inStruct.img[5]     = "instructions/instr_orchard_south.png"

		// trial - stimulus
		inStruct.txt[6]     = "Shortly after, an image of a tree appears, together with the key assignment.<br> you'll use the same buttons throughout the entire experiment!"
		inStruct.img[6]     =  "instructions/instr_stim_disp_south.png"

		// trial - decision
		inStruct.txt[7]     = "You decide whether you want to plant the tree or not.<br>To communicate your decision, you press either the left or right arrow key."
		inStruct.img[7]     = "instructions/instr_resp_choice.png";

		// trial - feedback 1
		inStruct.txt[8]     = " Right after you've pressed a button, we'll either put the tree in the garden or show an empty orchard.<br> Let's assume that you decided to plant the tree!"
		inStruct.img[8]     = "instructions/instr_stim_choice_plant_south.png" 

		// trial - feedback 2
		inStruct.txt[9]    = "After a short delay, you'll receive your reward/penalty. <br>This indicates if your choice was good or bad"
		inStruct.img[9]    = "instructions/instr_stim_fb_neg_south.png" 

		// trial - feedback 3
		inStruct.txt[10]    = "In the top half of the image, you see two numbers. <br> These are the rewards/penalties. <br> You always receive 0 reward for not planting a tree...";
		inStruct.img[10]    = "instructions/instr_stim_fb_neg_south_vals_reject.png" //TODO change, this is a placeholder

		// trial - feedback 4
		inStruct.txt[11]    = "..and either a reward or a penalty for planting a tree. <br> The value ranges from -50 to +50";
		inStruct.img[11]    = "instructions/instr_stim_fb_neg_south_vals_accept.png" //TODO change, this is a placeholder

		// trial - feedback 5
		inStruct.txt[12]    = "Also, if you decide to plant the tree, it either shrinks or grows, depending on your choice.<br> Remember: You want to receive rewards and thus plant trees that grow nicely!";
		inStruct.img[12]    = "instructions/instr_stim_fb_neg_south_tree_shrink.png" //TODO change, this is a placeholder

		// reminder
		inStruct.txt[13]    = "You need to learn which trees give you a large reward, and which trees give you a large penalty. <br>Plant those trees that give you a reward! <br> Avoid the other trees!";
		inStruct.img[13]    = ""; 

	    // structure
	    inStruct.txt[14]    ="There will be a TRAINING PHASE and a TEST PHASE. <br> You'll receive feedback only during the training phase <br> The training phase consists of two blocks and the test phase of one block. <br>All the blocks are of equal length.<br>There will be breaks between every block. <br>"
	    inStruct.img[14]    = [];
		// summary
		inStruct.txt[15]   = "<p><b> SUMMARY </b> <br>1. There are two gardens <br>2. Different types of trees grow best in each garden<br>3. Figure out which trees to plant and which trees to avoid<br>4. Maximize your reward!<br></p>";
		inStruct.img[15]   = [];

	}

	else if (taskID=='dissimrating_post') {
	
		inStruct.cap     = []; // caption/headline
		inStruct.txt     = []; // content
		inStruct.img     = []; // illustration
		 // sunnary
		 inStruct.txt[0]     = "<br> You'll now receive detailed instructions for the next task. <br> Please use the buttons below to navigate through these instructions."
		 inStruct.img[0]     = [];


		// whereami
		inStruct.txt[1]     = "Congratulations, you're almost done!<br> You're now in the POST phase of the experiment."
		inStruct.img[1]     = 'instructions/taskstructure_post.png'

		// summary
	     inStruct.txt[2]    = "<b>Dissimilarity ratings </b><br><br><br>In the next phase of the experiment, you'll do the same experiment as in the very beginning. To remind you, below is again the quick summary. <br><br>1. On each trial, you'll see 25 trees that are arranged in a circle. <br><br>2. Your task is to change the arrangement until the distances between all 25 trees reflects the pairwise dissimilarities.<br><br>3. Once you're satisfied with your arrangement, you'll click the next trial button to proceed with a new set of trees.<br><br>4. There will be six trials in total and it shouldn't take you longer than 15 minutes to finish this final phase of the experiment.<br><br><br>If you're ready to begin with the experiment, press the red start button below!";
	     inStruct.img[2]    = [];
	}

}




function gotoNextPage() {
/*
	changes div to next entry in instruction array
*/
	// move forward
	pageIDX++;
	changeInstructions();
	changeButtons();
}

function gotoPrevPage() {
/*
	changes div to previous entry in instruction array
*/
	// move backward
	pageIDX--;
	changeInstructions();
	changeButtons();
}


function changeInstructions() {
/*
	changes div content via html injection
*/
	
	$('.bodyText').html(inStruct.txt[pageIDX]);
	if (inStruct.img[pageIDX].length>0) {
		$('.bodyImg').html("<img id=instr_img src=" + inStruct.img[pageIDX] + ">");
	}
	else 
		$('.bodyImg').html("<!-- nothing to see here -->");
}


function changeButtons() {
/*
	changes properties of buttons 
*/
	console.log(pageIDX)

	if (pageIDX == 0) {	
		$('#prevButton').prop('disabled', true);
	}
	else {
		$('#prevButton').prop('disabled', false);
	}

	if (pageIDX == inStruct.txt.length-2) { 		
 		$('#nextButton').text('Next Page');
 		$('#nextButton').off('click');
 		$('#nextButton').attr('onclick',"gotoNextPage()");
 		$('.buttonBox#nextButton').css('background-color','rgba(249,167,50,1)');
 	}
	if (pageIDX == inStruct.txt.length-1) { 		
 		$('#nextButton').text('Start');
 		$('#nextButton').off('click');
 		if (instr_id=='dissimrating_pre' || instr_id=='dissimrating_post') {
 			$('#nextButton').attr('onclick',"startDissimRatingExperiment()");
 		}
 		else if (instr_id=='treetask_main') {
 			$('#nextButton').attr('onclick',"startMainExperiment()");
 		}

 		$('.buttonBox#nextButton').css('background-color','red');
 	}
}

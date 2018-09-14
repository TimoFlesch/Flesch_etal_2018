function startLoading() {
/*
  is supposed to preload images
*/

// found this snippet on the web, added callback
function preloadImages(srcs, continueExp) {
    if (!preloadImages.cache) {
        preloadImages.cache = [];
    }
    var img;
    var remaining = srcs.length;
    for (var i = 0; i < srcs.length; i++) {
        img = new Image();
        img.onload = function () {
            --remaining;

            if (remaining <= 0) {
               console.log('all images cached')
                continueExp();
            }
        };
        img.src = srcs[i];
        preloadImages.cache.push(img);

    }
    
      //continueExp();
}

var list =  gen_imgList();

// load images and execute callback once finished
preloadImages(list, function() {
  
  // if (preloadImages.cache.length==list.length){
     // newExperiment();

    instr_id='dissimrating_pre';
    setInstructions('dissimrating_pre');
    changeInstructions(); 
    goWebsite(html_taskinstr);
    startedinstructions=true;

   // }
});
}


function gen_imgList() {
/*
  generates list of filenames
*/
  imglist = [];

  // instructions:
  //TODO
  imglist.push('instructions/' + 'arrange.gif');
  imglist.push('instructions/' + 'dragndrop.gif');
  imglist.push('instructions/' + 'proceed.gif');
  imglist.push('instructions/' + 'canvas.png');
  imglist.push('instructions/' + 'instr_fb_empty_south.png');
  imglist.push('instructions/' + 'instr_fb_neg_south.png');
  imglist.push('instructions/' + 'instr_fb_pos_north.png');
  imglist.push('instructions/' + 'instr_orchard_north.png');
  imglist.push('instructions/' + 'instr_orchard_south.png');
  imglist.push('instructions/' + 'instr_resp_choice.png');
  imglist.push('instructions/' + 'instr_stim_choice_plant_south.png');
  imglist.push('instructions/' + 'instr_stim_disp_south.png');
  imglist.push('instructions/' + 'instr_stim_fb_neg_south_vals_accept_TEMPLATE.png');
  imglist.push('instructions/' + 'instr_stim_fb_neg_south_vals_accept.png');
  imglist.push('instructions/' + 'instr_stim_fb_neg_south_vals_reject.png');
  imglist.push('instructions/' + 'instr_stim_fb_neg_south_vals.png');
  imglist.push('instructions/' + 'instr_stim_fb_neg_south.png');
  imglist.push('instructions/' + 'instr_stim_south.png');
  imglist.push('instructions/' + 'taskstructure_main.png');
  imglist.push('instructions/' + 'taskstructure_post.png');
  imglist.push('instructions/' + 'taskstructure_pre.png');
  imglist.push('instructions/' + 'taskstructure.png');

  // orchards:
  imglist.push(parameters.gardenURL + "orchard_north.png");
  imglist.push(parameters.gardenURL + "orchard_south.png")

  // trees:
  exemplarList = parameters.exemplar_ids_train.concat(parameters.exemplar_ids_test)
  
  for(var b=1; b<=parameters.nb_branchiness; b++) {
    for(var l=1; l<=parameters.nb_leafiness; l++) {
      for(var e=1; e<=exemplarList.length; e++) {
          imglist.push(parameters.treeURL + "B" + b.toString() + "L" + l.toString() + "_" + exemplarList[e-1] + ".png")
      }
    }
  }
  return imglist;
}


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
    for (var i = 0; i < srcs.length; i++) {
        img = new Image();
        img.src = srcs[i];
        preloadImages.cache.push(img);

    }
      continueExp();
}

var list =  gen_imgList();

// load images and execute callback once finished
preloadImages(list, function() {
  console.log(preloadImages.cache.length)
  // if (preloadImages.cache.length==list.length){
      newExperiment();
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


// this is jan's old code which would probably work better than mine, if it weren't throwing an error.
//   var preload = function(srcs) {
//     images = []
//     for (i = 0; i < srcs.length; i++) {
//       images[i] = new Image()
//       images[i].onload = finishLoading
//       images[i].src    = srcs[i]
//   } }
//   var list =  ["trees/stims/b1l1_a.png","trees/stims/b2l5_a.png"];
//   console.log(list.length)
//   loadingexperiment = list.length
//   preload(applyMatrix(function(s){ return s },list))
// }

// function finishLoading() {
//   loadingexperiment -= 1
//   if (!loadingexperiment) {
//     newExperiment()
// } }

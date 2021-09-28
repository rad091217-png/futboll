// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
<<<<<<< HEAD
require_tree .
window.$ = window.jQuery = require('jquery')
import "bootstrap"
=======
require("jquery")
require("popper")
require("bootstrap")
>>>>>>> 1cdd56c7d019e001a6482d06f9b611ce2f89f890


window.onload = (function () {
  setTimeout("$('.time-limit-success').fadeOut('slow')", 5000)
})

window.onload = (function () {
  setTimeout("$('.time-limit-danger').fadeOut('slow')", 5000)
})
/*--------------------------------------------------------------------------*
 *  
 *  footerFixed.js
 *  
 *  MIT-style license. 
 *  
 *  2007 Kazuma Nishihata [to-R]
 *  http://blog.webcreativepark.net
 *  
 *--------------------------------------------------------------------------*/

window.onload = (function(){
  var $ftr = $('#footer');
  if( window.innerHeight > $ftr.offset().top + $ftr.outerHeight() ){
    $ftr.attr({'style': 'position:fixed; top:' + (window.innerHeight - $ftr.outerHeight()) + 'px;' });
  }
});
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
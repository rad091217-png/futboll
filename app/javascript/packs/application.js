// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
import "bootstrap"


$(function () {
  setTimeout("$('.time-limit-success').fadeOut('slow')", 5000)
})

$(function () {
  setTimeout("$('.time-limit-danger').fadeOut('slow')", 5000)
})
$(function () {
  //フッターを最下部に固定
  var $footer = $('#footer');
  if (window.innerHeight > $footer.offset().top + $footer.outerHeight()) {
    $footer.attr({
      'style': 'position:fixed; top:' + (window.innerHeight - $footer.outerHeight()) + 'px;'
    });
  }
})
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
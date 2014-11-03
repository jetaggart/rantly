// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.cookie
//= require_tree .

function setFlash(value) {
  $("nav").after("<div class='notice'>" + value + "</div>");
}

function checkForFlash() {
  var flash = $.cookie("flash");

  if (flash) {
    setFlash(flash);
    $.removeCookie("flash");
  }
}


function bindFavorite(target) {
  $(target)
    .on("ajax:success", function(event, responseText) {
      var newButton = $(responseText);
      bindFavorite(newButton);
      $(event.target).replaceWith(newButton);
    });
}

$(document).on("ready", function() {
  checkForFlash();

  $("#new_rant")
    .on("ajax:success", function() {
      $.cookie("flash", "Rant created");
      window.location.href = window.location.href;
    })
    .on("ajax:error", function(event, xhr) {
      $(event.target).replaceWith(xhr.responseText);
    });

  bindFavorite(".favorite");
});

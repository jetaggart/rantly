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
//= require pickadate/picker
//= require pickadate/picker.date
//= require Chart
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


function bindQuicklink(target) {
  $(target)
    .on("ajax:success", function(event, responseText) {
      var newButton = $(responseText);
      bindQuicklink(newButton);
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

  bindQuicklink(".quicklink");

  $("[data-datepicker]").pickadate({format: "yyyy-mm-dd"});

  var data = {
    labels : ["January","February","March","April","May","June","July"],
    datasets : [
      {
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : [65,59,90,81,56,55,40]
      },
      {
        fillColor : "rgba(151,187,205,0.5)",
        strokeColor : "rgba(151,187,205,1)",
        pointColor : "rgba(151,187,205,1)",
        pointStrokeColor : "#fff",
        data : [28,48,40,19,96,27,100]
      }
    ]
  }

  $("[data-chart]").each(function(_, chart) {
    var chart = $(chart);
    var data = chart.data('chart');

    new Chart(chart.get(0).getContext("2d")).Bar(data);
  });

});

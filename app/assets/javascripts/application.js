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
//= require turbolinks
//= require_tree .
//= require bootstrap

///////////////////////////////// FUNCTIONS ////////////////////////////////////
function updateCountdown() {
  var maxChars = 300;
  // 'comment_body' is the id of the css textfield we're using
  var remainingChars = maxChars - jQuery('#comment_body').val().length;

  // Text for feedback
  if( remainingChars >= 0 ) { var charsFeedback = ' characters remaining.' }
  else{ var charsFeedback = ' characters too many.' }

  // Return the text output of the chars concatenated with the string
  // .countdown is the CSS label it will fall under for incorporation
  jQuery('#countdown').text(Math.abs(remainingChars) + charsFeedback);
}

///////////////////////////////// LISTENERS ////////////////////////////////////

  // On ready, load the countdown & update it per additional listeners
  // Using .on('_listenerName_', function(_functionName_) {}) if current best-practice
  jQuery(document).ready(function($) {
    updateCountdown();
    $('#comment_body').on('change keyup input', updateCountdown);
  });

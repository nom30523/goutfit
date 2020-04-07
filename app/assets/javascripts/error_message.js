$(document).on('turbolinks:load', function() {
  setTimeout(function() {
    $('.error-alert').slideUp(100);
  },5000);
});
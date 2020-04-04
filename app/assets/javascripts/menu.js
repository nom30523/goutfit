$(document).on('turbolinks:load', function() {

  const menuBlock = $('.header-menu__block');

  menuBlock.hide();

  $('#show').on('click', function() {
    menuBlock.slideToggle(50);
  });
  
});


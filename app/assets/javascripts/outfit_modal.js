$(document).on('turbolinks:load', function() {
  
  // Outfitフォームモーダル
  $('.image-new').on('click', function() {

    $('html, body').scrollTop(0);
    
    // モーダル表示
    $('.outfit-modal-cover').show(50);
    $('.outfit-modal').show(50);

    // モーダルを閉じる
    $('.outfit-form-close').on('click', function() {
      $('.outfit-modal-cover').hide();
      $('.outfit-modal').hide();
    });
  });

});
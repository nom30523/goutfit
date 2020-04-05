$(document).on('turbolinks:load', function() {

  // Outfitフォームモーダル
  $('.outfit-btn').on('click', function() {
    
    // モーダル表示
    $('.outfit-modal-cover').show(50);
    $('.outfit-modal').show(50);

    // モーダルを閉じる
    $('.outfit-modal-close').on('click', function() {
      $('.outfit-modal-cover').hide();
      $('.outfit-modal').hide();
    });
  });
});
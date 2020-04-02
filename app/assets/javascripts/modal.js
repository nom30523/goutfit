$(document).on('turbolinks:load', function() {

  // モーダル表示
  $('.sign_btn').on('click', function() {

    $('.header-menu__block').hide();

    $('.modal-cover').show(50);
    $('.modal-form').show(50);

    let signUp = $(this).hasClass('sign-up-btn');
    let signIn = $(this).hasClass('sign-in-btn');

    if (signUp) {
      $('.modal-form__sign-up').show(50);
    } else if (signIn) {
      $('.modal-form__sign-in').show(50);
    }

    // モーダル切替
    $('.sign-change').on('click', function() {
      
      let changeSignUp = $(this).hasClass('change-sign-up');
      let changeSignIn = $(this).hasClass('change-sign-in');

      if (changeSignUp) {
        $('.modal-form__sign-in').hide();
        $('.modal-form__sign-up').show(50);
      } else if (changeSignIn) {
        $('.modal-form__sign-up').hide();
        $('.modal-form__sign-in').show(50);
      }

    });

    // モーダルを閉じる
    $('.modal-close').on('click', function() {
      $('.modal-cover').hide();
      $('.modal-form').hide();
      $('.modal-form__content').hide();
    });

  });

});

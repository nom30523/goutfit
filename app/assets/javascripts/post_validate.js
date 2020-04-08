$(document).on('turbolinks:load', function() {

  // エラーメッセージのhtml要素を生成
  const BuildErrorHtml = function(text, idName) {
    const postErrHtml = `<div class="post-error-text" id="post-error-${idName}">
                          <span>※${text}が選択されていません</span>
                         </div>`;

    return postErrHtml;
  }
  
  // submitボタンを押した際に発火
  $('#post-submit-btn').on('click', function(e) {
    
    // 遷移をキャンセルし、既にエラーメッセージがあれば消す。
    e.preventDefault();
    $('.post-error-text').remove();

    // falseの変数を用意
    let outfitErr = false;
    let dateErr = false;

    // 画像と日付の値を取得
    let outfitVal = $('input[name = "post[outfit_id]"]:checked').val();
    let dateVal = $('input[name = "post[appointed_day]"]').val();

    // 画像の選択がない場合にtrueへ変更
    if (outfitVal == null) {
      outfitErr = true;
    }
    // 日付の選択がない場合にtrueへ変更
    if (dateVal == '') {
      dateErr = true;
    }

    // エラーメッセージを表示する関数を定義
    const outfitErrText = function() {
      $('#post-outfit-text').after(BuildErrorHtml('画像', 'outfit'));
      $('.post-outfit-lists').css('border', '#ff3333 2px solid');

      // 画像選択の先頭付近へスクロールさせる為、位置を取得
      let position = $('.post-new-head').offset().top;
      // 画像選択へスクロールさせる
      $('html, body').animate({
        'scrollTop' : position
      }, 50);
      
      // 画像を選択した際、エラーメッセージを消す
      $('.post-form-img').on('change', function() {
        $('#post-error-outfit').remove();
        $('.post-outfit-lists').css('border', 'none');
      });
    }

    const dateErrText = function() {
      $('#post-date-text').after(BuildErrorHtml('日付', 'date'));
      $('.post-form-date').css('border', '#ff3333 2px solid');

      // 日付を選択した際、エラーメッセージを消す
      $('.post-form-date').on('change', function() {
        $('#post-error-date').remove();
        $('.post-form-date').css('border', '#efefef 1px solid');
      });
    }

    // 真偽値によって、エラーを表示する関数を呼び出す
    if (outfitErr && dateErr) {
      outfitErrText();
      dateErrText();
    } else if (outfitErr) {
      outfitErrText();
    } else if (dateErr) {
      dateErrText();
    } else {
      $('#post-form').submit();
    }

  });
});
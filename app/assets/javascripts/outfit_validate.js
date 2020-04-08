$(document).on('turbolinks:load', function() {

  // エラーメッセージのhtml要素を生成
  const BuildErrorHtml = function() {
    const outfitErrHtml = `<div class="outfit-error-text" id="outfit-error-img">
                            <span>※画像が選択されていません</span>
                           </div>`;

    return outfitErrHtml;
  }
  // submitボタンを押した際に発火
  $('#outfit-form-submit').on('click', function(e) {

    // 遷移をキャンセルし、既にエラーメッセージがあれば消す。
    e.preventDefault();
    $('outfit-error-text').remove();

    // falseの変数を用意
    let outfitImgErr = false;

    // 画像の値を取得
    const outfitImgVal = $('input[name = "outfit[image]"]').val();

    // 画像の選択がない場合にtrueへ変更
    if (outfitImgVal == '') {
      outfitImgErr = true;
    }

    // エラーメッセージを表示する関数を定義
    const outfitImgErrText = function() {
      $('.outfit-form-icon').before(BuildErrorHtml());
      $('.outfit-form-icon').css('border', '#ff3333 2px solid');

      // 画像を選択した際、エラーメッセージを消す
      $('#img-select-icon').on('click', function() {
        $('#outfit-error-img').remove();
        $('.outfit-form-icon').css('border', 'none');
      });
    }

    // 真偽値によって、エラーを表示する関数を呼び出す
    if (outfitImgErr) {
      outfitImgErrText();
    } else {
      $('#outfit-modal-form').submit();
    }
  });
});
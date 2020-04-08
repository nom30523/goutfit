$(document).on('turbolinks:load', function() {

  // 画像プレビューのhtml生成
  const buildImg = function(url) {
    const imgHtml = `<img src="${url}">`;
    return imgHtml;
  }

  // 画像を選択したタイミングで発火
  $('#outfit_image').on('change', function(e) {

    // 画像が変更された際に、元のプレビューを消す
    if (img = $('#outfit-icon-label').children('img')) {
      img.remove();
    }

    if ($('input[name = "outfit[image]"]').val() == '') {
      // 画像の選択が解除された場合、再度デフォルトiconを表示
      $('#img-select-icon').show();
    } else {
      // プレビュー画像の表示
      const file = e.target.files[0];
      const prevUrl = window.URL.createObjectURL(file);
      $('#img-select-icon').hide();
      $('#outfit-icon-label').prepend(buildImg(prevUrl));
    }

  });
});
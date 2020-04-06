$(document).on('turbolinks:load', function() {

  const buildImg = function(url) {
    const imgHtml = `<img src="${url}">`;
    return imgHtml;
  }

  $('#outfit_image').on('change', function(e) {
    
    if (img = $('label').children('img')) {
      img.remove();
    }

    const file = e.target.files[0];
    const prevUrl = window.URL.createObjectURL(file);

    $('#img-select-icon').hide();

    $('label').prepend(buildImg(prevUrl));

  });
});
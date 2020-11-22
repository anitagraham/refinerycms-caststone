  $(function() {
  var photoEditor_required = document.getElementById("componentsanddrawing_editor");
  if (photoEditor_required) {
    photoEditorInit()
  }
  let uploadButton = $('#drawing'),
      copyrightButton = $('a#copyright_button'),
      photoGrid = $('.photos_view, .drawings_view');

  if (copyrightButton.length) {
    $('form.edit_photo').on('click', 'a#copyright_button', function() {
      $.when( $.ajax({'url': '/refinery/caststone/photos/' + copyrightButton.data('photoid') + '/add_copyright.js'}))
       .then( function(data) {
        $('#photo.img').attr('src', data)
      })
    })
  }

  jQuery.fn.extend({
    disablePreview: function() {
      return this.each(function() {
        $(this).find('a.preview_icon').attr('href','#').prop('disabled', true).attr('tooltip', 'Broken image. No preview');
      });
    },
    warnBrokenImage: function(msg) {
      return this.each(function() {
        $(this).find('img').attr('alt', msg);
      });
    }
  });

  if (photoGrid.length) {
    photoGrid.imagesLoaded()
      .always(function (instance){
        photoList = photoGrid.find('>li');
        // detect which images are broken
        for ( var i = 0, len = instance.images.length; i < len; i++ ) {
          if (!instance.images[i].isLoaded) {
            $(photoList[i]).addClass('brokenImage').warnBrokenImage('Warning: this image is broken. Please edit and add a photo.').disablePreview();
          }
        }
    });
  };

  const showphoto_number = image => {
    photo_number = image.dataset.photo_number
    let span = document.createElement('span')
    span.innerText = photo_number
    span.classList.add('photo_number')
  }
  let gridImages = document.querySelectorAll(('#image_grid li > img'))
  gridImages.forEach(showphoto_number)

  let select = document.querySelector('.multiselect');
  if (select) {
    multi(select, {
      "enable_search": true,
      "search_placeholder": "Search...",
      "non_selected_header": 'Available',
      "selected_header": 'Selected',
       addButtonText: '>',
       removeButtonText: '<',
       addAllButtonText: '>>',
       removeAllButtonText: '<<',
      "limit": -1,
      "limit_reached": function () {
      },
    })
  }
});

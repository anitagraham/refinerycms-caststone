
$(function() {

  var seriesSelect = $('#photo_product_id'),
      uploadButton = $('#drawing'),
      redrawButton = $('a#redraw_button');
      copyrightButton = $('a#copyright_button');
      clearRadioButton = $('a.clearRadioSet');

  if (seriesSelect.length)  {
    $('div.fields').on('click', 'a#redraw_button', function (){
      updateDrawing();
      return false; })
    $('select#photo_product_id').change(function() {
      $.get('/refinery/caststone/products/' + this.value + '.js');
    });
  }

  $('.component_type').find("input:checkbox").click(function() {
      if ($(this).is(":checked")) {
          var group = "input:checkbox[name='" + $(this).attr("name") + "']";
          $(group).prop("checked", false);
          $(this).prop("checked", true);
      } else {
          $(this).prop("checked", false);
      }
  });

  if (clearRadioButton.length) {
    clearRadioButton.on('click', function () {
      $(this).parent().find('input').each(function() {
        this.checked =  false
      })
    })
  }

  if (redrawButton.length) {

    $('form.edit_photo').on('click', 'a#redraw_button', function() {

      var componentList = $('input:checked').map(function() { return this.value });
      $.when(
        $.ajax({
        'url': '/refinery/caststone/components/draw.png',
        'data': {list : $.makeArray(componentList) }
      })

       .then(function( data){
         $('img.drawing').attr('src', 'data:image/png;base64,' + data);
         // this second copy is used to save the latest drawing back to the db
         $('#photo_drawing').val(data)
       }));
      return false;
    })
  };

  if (copyrightButton.length) {
    $('form.edit_photo').on('click', 'a#copyright_button', function() {
      $.when( $.ajax({'url': '/refinery/caststone/photos/' + copyrightButton.data('photoid') + '/add_copyright.js'}))
       .then( function(data) {
        $('#photo.img').attr('src', data)  // replace the photo with the new copyright showing.
      })
    })
  };

  $('#photo_multiselect, #component_multiselect').multiselect({
    optionRenderer: function (el, grp){
    //transfer the data-url from the original select to the one created by multiselect
      return $('<div></div>').text(el.text()).addClass('image_popup').data('url', el.data('url'));
    }
  });

  $('.multiselect').parent().on('mouseover', '.image_popup', function(){
    var img = new Image(),
      src;
    if (this.nodeName == 'A') {
      src = this.href;
    }
    src = $(this).data('url') || '';
    img.src = src;
    var pup = $(img).addClass('popup');
    $(this).on('mouseout blur', function(){
      pup.hide();
      pup.remove();
    });
    $(this).after(pup);
    pup.show();
    img.focus();
    return false;
  });
  $('.image_popup').on('click', false);

  $('#page_photo_picker').on('multiselectChange', function(e,ui){
    $('img.popup').hide().remove();
  });
  // $('form').validatr();
});

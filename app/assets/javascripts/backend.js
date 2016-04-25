$(function() {

  var seriesSelect = $('#photo_product_id'),
      uploadButton = $('#drawing'),
      redrawButton = $('a#redraw_button');
      copyrightButton = $('a#copyright_button');
      clearRadioButton = $('a.clearRadioSet');

  if (seriesSelect.length)  {
    $('div.fields').on('click', 'a#redraw_button', function (){
      updateDrawing();
      return false; });
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
        this.checked =  false;
      });
    });
  }

  if (redrawButton.length) {

    $('form.edit_photo').on('click', 'a#redraw_button', function() {

      var componentList = $('input:checked').map(function() { return this.value;});
      $.when(
        $.ajax({
        'url': '/refinery/caststone/components/draw.png',
        'data': {list : $.makeArray(componentList) }
      })

       .then(function( data){
         $('img.drawing').attr('src', 'data:image/png;base64,' + data);
         // this second copy is used to save the latest drawing back to the db
         $('#photo_drawing').val(data);
       }));
      return false;
    });
  };

  if (copyrightButton.length) {
    $('form.edit_photo').on('click', 'a#copyright_button', function() {
      $.when( $.ajax({'url': '/refinery/caststone/photos/' + copyrightButton.data('photoid') + '/add_copyright.js'}))
       .then( function(data) {
        $('#photo.img').attr('src', data);  // replace the photo with the new copyright showing.
      });
    });
  };

  function setup_multiSelect() {
    function counts(el) {
      all = el.find('option').length;
      sel = el.find('option').filter(':selected').length;
      return {
        available: all -sel,
        selected: sel
      };
    }

    function updateHeader(counts) {
      available_text = counts['available'] + ' Available Items';
      selected_text =  counts['selected'] + ' Selected Items';
      mu.next('.ms-container').find('.ms-selectable .custom-header').text(available_text);
      mu.next('.ms-container').find('.ms-selection  .custom-header').text(selected_text);
      return this;
    }

    var mu = $(this);
    mu.multiSelect({
      selectableHeader: "<div class='custom-header'/>",
      selectionHeader:  "<div class='custom-header'/>",
      selectableFooter: "<div class='custom-header'>Available</div>",
      selectionFooter:  "<div class='custom-header'>Selected</div>",
      afterInit: function()     {updateHeader(counts(mu));},
      afterSelect: function()   {updateHeader(counts(mu));},
      afterDeselect: function() {updateHeader(counts(mu));}
    });
    return this;
  };

  $('.multiselect').each(setup_multiSelect);

});

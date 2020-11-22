let seriesChange = function (series_id){

  $.ajax({
    url: `/refinery/caststone/products/${series_id}/list_components.js`,
    type: 'get',
    success: data => $('.selectComponents').innerHTML = data.html
  })
}
$(function() {
  let seriesSelect = document.querySelector('#selectSeries .radio_buttons')
  if (seriesSelect) {
    seriesSelect.addEventListener('change', e => {
      if (e.target.closest('[name="photo[product_id]"')) {
        seriesChange(e.target.value)
      }
    })
  }
})

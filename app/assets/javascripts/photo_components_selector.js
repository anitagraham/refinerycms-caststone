
const clearComponentButtons = event => {
  buttonSet = event.target.parentNode
  let buttons =buttonSet.getElementsByTagName('input')
  for(let button of buttons){ button.checked =false }
}

const clearDrawing = drawing => {
  drawing.src = ''
  drawing.alt = "No components selected. Select components and Redraw"
  drawing.classList.add('warning')
}
const setDrawing = (drawing, data) => {
  let photo_title = document.querySelector('input#photo_name').value
  drawing.src = 'data:image/png;base64,' + data
  drawing.classList.remove('warning')
  drawing.alt = `Drawing of ${photo_title}`
}

const redrawHandler = async event => {
  if (event.target.id !== 'redraw_button') return

  event.target.preventDefault
  event.target.stopPropagation
  let redraw = event.target

  let photoId = redraw.dataset.photoId
  let componentList = document.querySelectorAll('#selectComponents input[type=checkbox]:checked')
  let components = [...componentList].map(el => el.value);
  let drawing = document.querySelector('img.drawing')
  let drawingFormField = document.getElementById('photo_drawing')

  if (components.length === 0) {
    clearDrawing(drawing);
    drawingFormField.value = ''
    return;
  }
  url = new URL(`refinery/caststone/photos/${photoId}/draw`, document.location.origin)
  components.forEach(comp => url.searchParams.append('component_ids[]', comp))

  let response = await fetch(url)
  if (response.ok) {

    let drawingInfo = await response.blob()

    if (drawingInfo.type === "image/png") {
      drawingData = await drawingInfo.text()
      setDrawing(drawing, drawingData)
      drawingFormField.value = drawingData
    } else {
      console.log(`Unexpected drawing type: ${drawingInfo.type}`)
    }
  } else {
    console.log(response.status)
    console.log(resonse.statusText)
  }

  return false;
}

const photoEditorInit = () => {
  document.addEventListener('click', redrawHandler)
  clearButtons = document.querySelectorAll('a.clearComponentSet')
  clearButtons.forEach( button => button.addEventListener('click', clearComponentButtons))
}


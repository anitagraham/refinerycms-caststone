// Use this to customize the visual editor boot process
// Just mirror the options specified in your visual editor's config with the new
// options here.  This will completely override anything specified in your visual
// editor's boot process for that key, e.g. skin: 'something_else'
  var custom_visual_editor_boot_options = {
    classesItems: [
      {name: 'button-download', rules:['button', 'download'], join: '-'},
      {name: 'button-cta',      rules:['button', 'cta'], join: '-'},
      {name: 'text-align',      rules:['left', 'center', 'right', 'justify'], join: '-'},
      {name: 'image-align',     rules:['left', 'right'], join: '-'},
      {name: 'font-size',       rules:['small','normal','large'], join: '-'},
    ],
    containersItems: [
      {'name': 'h1', 'title':'Heading_1', 'css':'wym_containers_h1'},
      {'name': 'h2', 'title':'Heading_2', 'css':'wym_containers_h2'},
      {'name': 'h3', 'title':'Heading_3', 'css':'wym_containers_h3'},
      {'name': 'p', 'title':'Paragraph', 'css':'wym_containers_p'},
      {'name': 'box', 'title': 'Box', 'css': 'wym_containers_box'},
    ]
  };


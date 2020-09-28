wymeditor_boot_options.toolsItems.push({'name': 'AddButton', 'title': 'Add_Button', 'css': 'wym_tools_add_Button'});

onCloseDialog = function(){
  $('iframe#dialog_iframe').attr('src', '');
};

WYMeditor.editor.prototype.exec_without_Button = WYMeditor.editor.prototype.exec;
WYMeditor.editor.prototype.exec = function(cmd) {
  if (cmd === 'AddButton') {
    this.dialog('Button');
  } else this.exec_without_Button(cmd);
};

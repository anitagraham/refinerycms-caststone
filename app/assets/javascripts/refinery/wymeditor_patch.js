wymeditor_boot_options.toolsItems.push({'name': 'AddCallToAction', 'title': 'Add_CallToAction', 'css': 'wym_tools_add_CallToAction'});

onCloseDialog = function(){
  $('iframe#dialog_iframe').attr('src', '');
};

WYMeditor.editor.prototype.exec_without_CallToAction = WYMeditor.editor.prototype.exec;
WYMeditor.editor.prototype.exec = function(cmd) {
  if (cmd === 'AddCallToAction') {
    this.dialog('CallToAction');
  } else this.exec_without_CallToAction(cmd);
};

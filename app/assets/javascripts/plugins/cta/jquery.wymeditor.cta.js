/* global rangy */
"use strict";

/**
 * An HTML macro wrapper for calls to action
 * @param options A configuration object.
 * @param wym The WYMeditor instance to which the TableEditor should attach.
 * @class
 */
function CallToActionEditor(options, wym) {
  var ctaEditor = this;
  options = jQuery.extend({
    sAddCtaButtonHtml: String() +
    '<li class="wym_tools_add_cta">' +
    '<a name="add_cta" href="#" title="Add Call to Action">' +
    'Add Call to Action' +
    '</a>' +
    '</li>',

    sAddCtaButtonSelector: "li.wym_tools_add_cta a",

    sDelCtaButtonHtml: String() +
    "<li class='wym_tools_delete_cta'>" +
    "<a name='delete_cta' href='#' title='Delete Call to Action' " +
    "Delete Call to Action" +
    "</a>" +
    "</li>",
    sDelCtaButtonSelector: "li.wym_tools_delete_cta a",

    sEditCtaButtonHtml: String() +
    "<li class='wym_tools_edit_cta'>" +
    "<a name='edit_cta' href='#' title='Edit Call to Action' " +
    "Edit Call to Action" +
    "</a>" +
    "</li>",
    sRemoveRowButtonSelector: "li.wym_tools_edit_cta a"
  }, options);

  ctaEditor._options = options;
  ctaEditor._wym = wym;

  ctaEditor.init();
}

/**
 * Construct and return a cta object using the given options object.
 *
 * @param options The configuration object.
 */
WYMeditor.editor.prototype.cta = function (options) {
  var wym = this,
    ctaEditor = new CallToActionEditor(options, wym);

  wym.ctaEditor = ctaEditor;
  return ctaEditor;
};

/**
 * Initialize the ctaEditor object by adding appropriate toolbar buttons and
 * binding any required event listeners.
 */
CallToActionEditor.prototype.init = function () {
  var ctaEditor = this,
    wym = ctaEditor._wym,
    // Add the tool panel buttons
    tools = jQuery(wym._box).find(
      wym._options.toolsSelector + wym._options.toolsListSelector
    );

  tools.append(ctaEditor._options.sAddCtaButtonHtml);
  tools.append(ctaEditor._options.sDelCtaButtonHtml);
  tools.append(ctaEditor._options.sEditCtaButtonHtml);

  ctaEditor.bindEvents();
  rangy.init();
};

/**
 * Bind all required event listeners
 */
CtaEditor.prototype.bindEvents = function () {
  var ctaEditor = this,
    wym = ctaEditor._wym;

  // Handle tool button click
  jQuery(wym._box).find(
    ctaEditor._options.sAddCtaButtonSelector
  ).click(function () {
    return ctaEditor.addCta(wym.selectedContainer());
  });
  // jQuery(wym._box).find(
  //   ctaEditor._options.sRemoveCtaButtonSelector
  // ).click(function () {
  //   return ctaEditor.removeCta(wym.selectedContainer());
  // });
  // jQuery(wym._box).find(
  //   ctaEditor._options.sEditCtaButtonSelector
  // ).click(function () {
  //   return ctaEditor.EditCta(wym.selectedContainer());
  // });
};

CtaEditor.prototype.addCta = function (element) {
  var ctaEditor = this,
    wym = ctaEditor._wym,
    ctaHtml,
    ctaDetails,
    i,
    container,
    selectedNode,
    ctaTemplate = '<li data-equalizer-watch="cta">\n' +
    '    <div class="inner">\n' +
    '      <a href="{{url}}"> <h3 class="{{icon}}">{{header}}</h3>\n' +
    '      <p>\n' +
    '        {{text}}\n' +
    '      </p> </a>\n' +
    '    </div>\n' +
    '  </li>';
  // open the dialog
  ctaDetails = wym.dialog(AddCtaDialog);

  ctaHtml = Mustache.render(ctaTemplate, ctaDetails)
  if (!container || !container.parentNode) {
    // No valid selected container. Put the cta at the end.
    wym.$body().append(ctaHtml);

  } else {
    jQuery(selectedNode).after(ctaHtml);
  }
  wym.registerModification();
  return false;
};


var AddCtaDialog = {
  title: "CallToAction",
    shouldOpen: function () {
    var wym = this;
    if (
      wym.hasSelection() !== true ||
      wym.selection().isCollapsed !== true
    ) {
      return false;
    }
    return true;
  },
  getBodyHtml: function () {
    var wym = this;
    return wym._options.dialogTableHtml || String() +
      '<form>' +
      '<fieldset>' +
      '<input type="hidden" class="wym_dialog_type" ' +
      'value="' + WYMeditor.DIALOG_CTA+ '" />' +
      '<legend>{Call to Action}</legend>' +
      '<div class="row">' +
      '<label>{Header}</label>' +
      '<input type="text" class="wym_header" ' +
      'value="" size="40" />' +
      '</div>' +
      '<div class="row">' +
      '<label>{Text}</label>' +
      '<input type="text" class="wym_text" ' +
      'value="" size="40" />' +
      '</div>' +
      '<div class="row">' +
      '<label>{URL}</label>' +
      '<input type="text" class="wym_url" ' +
      'value="3" size="3" />' +
      '</div>' +
      '<div class="row">' +
      '<label>{Icon}</label>' +
      '<input type="text" class="wym_icon" ' +
      'value="2" size="3" />' +
      '</div>' +
      '<div class="row row-indent">' +
      '<input class="wym_submit" type="submit" ' +
      'value="{Submit}" />' +
      '<input class="wym_cancel" type="button" ' +
      'value="{Cancel}" />' +
      '</div>' +
      '</fieldset>' +
      '</form>';
  },
  getBodyClass: function () {
    var wym = this;
    return wym._options.dialogCtaSelector || "wym_dialog_cta";
  },
  submitHandler: function (wDialog) {
    var wym = this,
      options = wym._options,
      doc = wDialog.document,
      header = jQuery(options.headerSelector, doc).val(),
      icon = jQuery(options.iconSelector, doc).val(),
      text = jQuery(options.textSelector, doc).val(),
      url = jQuery(options.urlSelector, doc).val();

    wDialog.close();
    return {'icon': icon, 'header': header, 'text': text, 'url': url}
  }
}

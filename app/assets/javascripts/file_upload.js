// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//= require jquery.ui.widget
//= require tmpl.min
//= require load-image.min
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-ui
//= require jquery.xdr-transport
// require pictures/customupload
// require pictures/form

$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    //$('#fileupload').fileupload();
		$('#fileupload').fileupload({
      maxNumberOfFiles: 1,
      acceptFileTypes: /\.(jpg|jpeg|gif|png|JPG|JPEG|GIF|PNG)$/
    });

    if (window.location.hostname === 'blueimp.github.com') {
        // Demo settings:
        $('#fileupload').prop(
            'action',
            '//jquery-file-upload.appspot.com'
        );
        $('#fileupload').fileupload('option', {
            maxFileSize: 5000000,
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
        });
    } else {
        // Load existing files:
        $.getJSON($('#fileupload').prop('action'), function (files) {
            var fu = $('#fileupload').data('fileupload'),
                template;
            fu._adjustMaxNumberOfFiles(-files.length);
            template = fu._renderDownload(files)
                .appendTo($('#fileupload .files'));
            // Force reflow:
            fu._reflow = fu._transition && template.length &&
                template[0].offsetWidth;
            template.addClass('in');
        });
    }

    // Enable iframe cross-domain access via redirect page:
    var redirectPage = window.location.href.replace(
        /\/[^\/]*$/,
        '/result.html?%s'
    );
    $('#fileupload').bind('fileuploadsend', function (e, data) {
        if (data.dataType.substr(0, 6) === 'iframe') {
            var target = $('<a/>').prop('href', data.url)[0];
            if (window.location.host !== target.host) {
                data.formData.push({
                    name: 'redirect',
                    value: redirectPage
                });
            }
        }
    });

    // Open download dialogs via iframes,
    // to prevent aborting current uploads:
    $('#fileupload .files').delegate(
        'a:not([rel^=gallery])',
        'click',
        function (e) {
            e.preventDefault();
            $('<iframe style="display:none;"></iframe>')
                .prop('src', this.href)
                .appendTo(document.body);
        }
    );

    // Initialize the Bootstrap Image Gallery plugin:
    $('#fileupload .files').imagegallery();

});
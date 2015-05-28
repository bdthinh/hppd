/*
 * jQuery File Upload Plugin JS Example 8.9.1
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/* global $, window */

$(function() {
    'use strict';
    $('#fileupload').fileupload({
        url: '/videos',
        dataType: 'json',
        done: function(e, data) {
          alert(data.result.message);
          window.location = data.result.url;
        }
    });
});

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require cocoon
//= require bootstrap-tabs
//= require_tree .
$(document).ready(function() {
    $("#category a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this');

    $('#category').bind('cocoon:after-insert',
         function(e, tag) {
             $(".category-fields a.add_fields").
                 data("association-insertion-position", 'before').
                 data("association-insertion-node", 'this');
             $('.category-fields').bind('cocoon:after-insert',
                  function() {
                    $(this).children("#category_from_list").remove();
                    $(this).children("a.add_fields").hide();
                  });
         });

    $('#menu_items').bind('cocoon:before-insert', function(e,task_to_be_added) {
        task_to_be_added.fadeIn('slow');
    });

    $('#menu_items').bind('cocoon:after-insert', function(e, added_task) {
        //added_task.css("background","red");
    });

    $('#menu_items').bind('cocoon:before-remove', function(e, task) {
        $(this).data('remove-timeout', 1000);
        task.fadeOut('slow');
    })

    $('body').tabs();
});
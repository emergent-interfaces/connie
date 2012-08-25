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
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.purr
//= require jquery-ui
//= require best_in_place
//= require_tree .

$(document).ready(function() {

     // Unobtrusive formatting of set_default_convention_form for browsers with Javascript
    /*$('#set_default_convention_form input').hide();
    $('#set_default_convention_form select').change(function(){
       $(this).closest("form").submit();
    });*/
    $('#set_default_convention_form').hide();
    $('#js_con_filter').show();
    $('.dropdown-toggle').dropdown();

    var labels,mapped;

    // Search box typeahead
    $('.search-query').typeahead({
        items: 20,
        source: function(query, process) {
            $.get('/search.json',{utf8: "✓",text: query}, function(data){
                labels = [];
                mapped = {};

                _.each(data, function(item) {
                   switch (item.class_name) {
                       case "Event":
                           icon = "<i class='icon-calendar'></i>";
                           break;
                       case "Space":
                           icon = "<i class='icon-globe'></i>";
                           break;
                       case "Profile":
                           icon = "<i class='icon-user'></i>";
                           break;
                       default:
                           icon = "";
                   }

                   label = icon + " " + item.name;
                   mapped[label] = item.name;
                   labels.push(label);
                });

                process(labels);
            });
        },
        updater: function(item) {
            $('.search-query').parent().find('#jump_to_match').val(true);
            $('.search-query').val(mapped[item]);
            $('.search-query').parent().submit();
            return mapped[item];
        }
    });

    // Search box hotkey
    // https://github.com/tzuryby/jquery.hotkeys
    $(document).bind('keydown.ctrl_i', function() {
        $('.search-query').focus();
    });

    // Unobtrusive formatting of Events
    $('.model_tools').hide();
    $('.page-header').hover(
        function() { $(this).find('.model_tools').fadeIn(100) },
        function() {$(this).find('.model_tools').fadeOut(100) }
    );

    // Add bindings for best_in_place
    jQuery(".best_in_place").best_in_place();

    $(".best_in_place").hover(
        function () { $(this).addClass('best_in_place_highlight'); },
        function() { $(this).removeClass('best_in_place_highlight'); }
    );
});
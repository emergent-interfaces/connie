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
//= require jquery.purr
//= require best_in_place
//= require_tree .

$(document).ready(function() {

    // Unobtrusive formatting of set_default_convention_form for browsers with Javascript
    $('#set_default_convention_form input').hide();
    $('#set_default_convention_form select').change(function(){
       $(this).closest("form").submit();
    });

    // Unobtrusive formatting of Events
    $('.model_tools').hide();
    $('#event_name').hover(
        function() { $(this).find('.model_tools').show() },
        function() {$(this).find('.model_tools').hide() }
    );
    $('#space_name').hover(
        function() { $(this).find('.model_tools').show() },
        function() {$(this).find('.model_tools').hide() }
    );
    $('#user_name').hover(
        function() { $(this).find('.model_tools').show() },
        function() {$(this).find('.model_tools').hide() }
    );


    // Add bindings for best_in_place
    jQuery(".best_in_place").best_in_place();

    $(".best_in_place").hover(
        function () { $(this).addClass('best_in_place_highlight'); },
        function() { $(this).removeClass('best_in_place_highlight'); }
    );
});
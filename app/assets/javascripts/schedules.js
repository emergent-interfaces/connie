// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

    console.log('test');
    $('.nav-tabs a').click(function(e) {
        e.preventDefault();
        $(this).tab('show');
    });

});

$(document).ready(function() {

    if ($('input#space_inherit_address').is(':checked')) {
        $('#space_own_address_attributes_text').attr("disabled","disabled")
    } else {
        $('#space_own_address_attributes_text').removeAttr("disabled")
    }

    $('input#space_inherit_address').change(function() {
        if ($(this).is(':checked')) {
            $('#space_own_address_attributes_text').attr("disabled","disabled")
        } else {
            $('#space_own_address_attributes_text').removeAttr("disabled")
        }
    });

});
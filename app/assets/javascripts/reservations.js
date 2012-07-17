var $inherit_time_span_check_box = $('#reservation_inherit_time_span');
var $time_span_controls = $('[id^=reservation_own_time_span_attributes]');

$inherit_time_span_check_box.click(function() {
    if ($inherit_time_span_check_box.is(':checked') == 1) {
        $time_span_controls.attr('disabled','disabled');
    } else {
        $time_span_controls.removeAttr('disabled');
    }
});
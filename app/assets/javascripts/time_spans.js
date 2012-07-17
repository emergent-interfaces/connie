var typewatch = (function(){
    var timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    }
})();

var $start_time = $('[id$=_start_time]');
var $end_time = $('[id$=_end_time]');

var parse_fail = "Format not understood";


function to12Hrs(strHrs, strMin) {
    var hrs = Number(strHrs);
    var min = Number(strMin);
    var ampm = "am";

    if(isNaN(hrs) || isNaN(min) || hrs > 23 || hrs < 0)   {
        throw ("Invalid Date " + str24Hrs);
    }

    if(hrs >= 12)   {
        hrs = (hrs - 12) || 12;
        ampm = "pm";
    }
    var strHr = (hrs < 10) ? "0".concat(hrs) : hrs;
    var strMin = (min < 10) ? "0".concat(min) : min;
    return (strHr + ":" + strMin + ampm);
}

function format_time(time) {
    var time = new Date(time);
    return $.datepicker.formatDate('MM d, yy',time) + " " + to12Hrs(time.getHours(), time.getMinutes());
}

function validate_format_call($control, hint_id) {
    if ($control.val() != "") {
        $.getJSON('/chronic/'+$control.val() + '.json', function(data) {
            if (data.result) {
                $control.parent().parent().removeClass('error');

                if ($('#'+hint_id).length != 0) {
                    $('#'+hint_id).html(format_time(data.result))
                } else {
                    $control.after("<span class='help-inline' id='"+hint_id+"'>"+format_time(data.result)+"</span>");
                }
            }
            else
            {
                $control.parent().parent().addClass('error');

                if ($('#'+hint_id).length != 0) {
                    $('#'+hint_id).html(parse_fail);
                } else {
                    $control.after("<span class='help-inline' id='"+hint_id+"'>"+parse_fail+"</span>");
                }
            }
        });
    } else {
        $('#'+hint_id).html("");
    }
}

function validate_time_format($control, hint_id) {
    $control.keyup(function() {
        typewatch(function() {
            validate_format_call($control,hint_id);
        }, 500);
    });

    $control.blur(function() {
        validate_format_call($control,hint_id);
    });
}

validate_time_format($start_time, 'start_time_hint');
validate_time_format($end_time, 'end_time_hint');
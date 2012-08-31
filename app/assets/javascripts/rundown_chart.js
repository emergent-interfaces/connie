google.load('visualization','1.0', {'packages':['corechart']});
google.setOnLoadCallback(google_charts_callback);

function google_charts_callback() {
    console.log('Google Charts Loaded');
}

$(document).ready(function() {
    var chart = $('.rundown_chart');

    _.each(chart, function(schedule) {
        $.getJSON($(schedule).data('url'),
            function(data) {
                console.log(data);
                draw_rundown_chart(schedule,data);
            }
        );
    });

    function draw_rundown_chart(container,data)
    {
        var dt = new google.visualization.DataTable();
        dt.addColumn('datetime', 'Date');
        dt.addColumn('number', 'Running');

        var previous_running_count = data.summary[0].running_count;

        _.each(data.summary,function(datum) {
            var date = new Date(datum.time);
            //console.log(datum.time)
            //console.log(date);

            var predate = new Date(date-1);
            dt.addRow([predate,
                previous_running_count]);

            dt.addRow([date,
                      datum.running_count]);

            previous_running_count = datum.running_count;
        });

        var options = {'title':'Running Events',
            'legend': {position: 'none'},
            'width':'100%',
            'height':180};

        var chart = new google.visualization.LineChart(container);
        chart.draw(dt,options);
    }


});
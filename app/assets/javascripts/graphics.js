function chart_of_the_historic_of_metric (container_id, metric_name, module_name, date_list, metric_values_list)
{
  date_list = date_list.split(',');
  metric_values_list = metric_values_list.split(',');
  for(var i = 0; i < metric_values_list.length; i++) {
    metric_values_list[i] = parseInt(metric_values_list[i]);
  }
  $('#tr_container_' + container_id).hide();

  $(function () {
        $('#container_'+container_id).highcharts({
            title: {
                text: metric_name,
                x: -20 //center
            },
            subtitle: {
                text: module_name,
                x: -20
            },
            xAxis: {
                categories: date_list
            },
            yAxis: {
                title: {
                  text: 'Value'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            series: [{
                name: 'Metric value',
                data: metric_values_list
            }]
        });
    });
  $('#tr_container_' + container_id).show("slow");
}
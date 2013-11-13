function chart_of_the_historic_of_metric (json_params, dinamic_values)
{
  container_id = json_params['container_id'];
  metric_name = json_params['metric_name'];
  module_name = json_params['module_name'];
  dates = dinamic_values['dates'];
  metric_values = dinamic_values['values'];

  $('#tr_container_' + container_id).hide();
  $(function () {
    $('#container_'+container_id).highcharts({
      chart: {
        marginBottom: 80,
        width: 600,
        style: {margin: '0 auto'}
      },
      title: {
        text: metric_name,
        x: -20 //center
      },
      subtitle: {
        text: module_name,
        x: -20
      },
      xAxis: {
        categories: dates
      },
      yAxis: {
        title: {
          text: 'Value'
        },
        labels: {
        align: 'left',
        x: 0,
        y: -2
      },
      plotLines: [{
        value: 0,
        width: 1,
        color: '#808080'
      }]
      },
      series: [{
        name: 'Metric value',
        data: metric_values
      }]
    });
  });

  $('#tr_container_' + container_id).show("slow");
}
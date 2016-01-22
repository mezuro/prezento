#= require spec_helper
#= require metric_collector

describe "MetricCollector", ->
  describe 'choose_metric', ->
    before ->
      sinon.stub(window, "$")

      @metric_code = 'acc'
      @metric_code_field = sinon.stub()
      @metric_code_field.val = sinon.stub().withArgs(@metric_code)

      @metric_collector_name = 'Analizo'
      @metric_collector_name_field = sinon.stub()
      @metric_collector_name_field.val = sinon.stub().withArgs(@metric_collector_name)

      @form = sinon.stub()
      @form.submit = sinon.stub()
      @action_path = '/en/kalibro_configurations/1/metric_configurations/new'
      @form.attr = sinon.stub().withArgs('action', @action_path)

      $.withArgs("#metric_code").returns(@metric_code_field)
      $.withArgs("#metric_collector_name").returns(@metric_collector_name_field)
      $.withArgs("form").returns(@form)

    it 'is expected to fill in the form and submit', ->
      MetricCollector.choose_metric(@metric_code, @metric_collector_name, @action_path)

      sinon.assert.calledOnce(@metric_code_field.val, @metric_code)
      sinon.assert.calledOnce(@metric_collector_name_field.val, @metric_collector_name)
      sinon.assert.calledOnce(@form.submit)
      sinon.assert.calledOnce(@form.attr, 'action', @action_path)


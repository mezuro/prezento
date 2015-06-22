#= require spec_helper
#= require Chart
#= require module/graphic

describe "Module.Graphic", ->
  before ->
    @container = 'container404829'
    @metric_name = 'Pain'
    @module_id = '54405'

    sinon.stub(window, "$")

    @drawer = sinon.stub()
    @drawer.is = sinon.stub().withArgs(':hidden').returns(false)
    @drawer.slideUp = sinon.stub()
    $.withArgs("tr#"+@container).returns(@drawer)

  describe "constructor", ->
    context 'when the drawer is hidden', ->
      before ->
        @drawer.is = sinon.stub().withArgs(':hidden').returns(true)
        @drawer.slideDown = sinon.stub()
        sinon.stub(Module.Graphic.prototype, 'load')

      it "should show the drawer and start to load a graphic", ->
        @graphic = new Module.Graphic(@container, @metric_name, @module_id)

        sinon.assert.calledOnce(@drawer.slideDown)
        sinon.assert.calledOnce(@graphic.load)

      after ->
        @drawer.is = sinon.stub().withArgs(':hidden').returns(false)
        @drawer.slideDown = undefined
        Module.Graphic.prototype.load.restore()

    context 'when the drawer is visible', ->
      it 'should hide the drawer', ->
        @graphic = new Module.Graphic(@container, @metric_name, @module_id)

        sinon.assert.calledOnce(@drawer.slideUp)

  describe 'load', ->
    before ->
      @graphic = new Module.Graphic(@container, @metric_name, @module_id)

    it 'should make a POST request', ->
      $.post = sinon.stub().withArgs('/modules/' + @module_id + '/metric_history', {metric_name: @metric_name, container: @container})

      @graphic.load()

      sinon.assert.calledOnce($.post, '/modules/' + @module_id + '/metric_history', {metric_name: @metric_name, container: @container})

  describe 'display', ->
    beforeEach ->
      canvas_context = sinon.stub()
      @canvas = sinon.stub()
      @canvas.getContext = sinon.stub().withArgs('2d').returns(canvas_context)

      elements = sinon.stub()
      elements.get = sinon.stub().withArgs(0).returns(@canvas)
      $.withArgs('canvas#'+@container).returns(elements)

      @dates = ["2015-06-17", "2015-06-18", "2015-06-19"]
      @values = [1.2, 2.3, 3.4]

      opts = {
        bezierCurve: false,
        responsive: true,
        maintainAspectRatio: false
      }

      data = {
        labels : @dates,
        datasets : [
          {
            fillColor : "rgba(220,220,220,0.5)",
            strokeColor : "rgba(220,220,220,1)",
            pointColor : "rgba(220,220,220,1)",
            pointStrokeColor : "#000",
            data : @values
          }
        ]
      }

      @line = sinon.stub().withArgs(data, opts)
      sinon.stub(window, 'Chart').withArgs(canvas_context).returns({Line: @line})

    context 'when the graphic exists', ->
      it 'should render the chart', ->
        Module.Graphic.display(@dates, @values, @container)
        sinon.assert.calledOnce(@line)

    context 'when the graphic does not exists', ->
      beforeEach ->
        @chart = sinon.stub()
        @chart.destroy = sinon.stub()
        @canvas.chart = @chart
        @canvas.hasOwnProperty = sinon.stub().withArgs("chart").returns(true)

      it 'should destroy the previous chart and render a new one', ->
        Module.Graphic.display(@dates, @values, @container)
        sinon.assert.calledOnce(@chart.destroy)
        sinon.assert.calledOnce(@line)

    afterEach ->
      Chart.restore()

  after ->
    $.restore()

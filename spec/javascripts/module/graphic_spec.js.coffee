#= require jquery
#= require spec_helper
#= require modules
#= require module/graphic
#= require sinon

describe "Module.Graphic", ->
  describe "constructor", ->
    before ->
      @container = 'container404829'
      @metric_name = 'Pain'
      @module_id = '54405'

      @drawer = sinon.stub()
      sinon.stub(window, "$")
      $.withArgs("tr#"+@container).returns(@drawer)

    context 'when the drawer is hidden', ->
      before ->
        @drawer.is = sinon.stub().withArgs(':hidden').returns(true)

      it "should show the drawer and start to load a graphic", ->
        @drawer.slideDown = sinon.spy()

        Module.Graphic.prototype.load = sinon.spy()

        @graphic = new Module.Graphic(@container, @metric_name, @module_id)

        assert.isTrue(@drawer.slideDown.calledOnce)
        assert.isTrue(@graphic.load.calledOnce)

    context 'when the drawer is visible', ->
      before ->
        @drawer.is = sinon.stub().withArgs(':hidden').returns(false)

      it 'should hide the drawer', ->
        @drawer.slideUp = sinon.spy()

        @graphic = new Module.Graphic(@container, @metric_name, @module_id)

        assert.isTrue(@drawer.slideUp.calledOnce)

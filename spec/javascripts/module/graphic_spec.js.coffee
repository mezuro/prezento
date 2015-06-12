#= require jquery
#= require spec_helper
#= require modules
#= require module/graphic

describe "Graphic#constructor", ->
  describe 'with a visible drawer', ->
    before () ->
      @container = 'container404829'
      @metric_name = 'Pain'
      @module_id = '54405'
      $('body').html(JST['templates/metric_results']({container: @container, metric_name: @metric_name, module_id: @module_id}))

    it "should construct a graphic", ->
      graphic = new Module.Graphic(@container, @metric_name, @module_id)


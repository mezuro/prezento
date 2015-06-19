#= require spec_helper
#= require repository/branch

describe "Repository.Branch", ->
  beforeEach ->
    @subject = new Repository.Branch()

  describe "constructor", ->
    it "should construct a branch", ->
      @subject.names.should.deep.equal({})
      assert.isNull(@subject.request)

  describe "#toggle", ->
    before ->
      @combo_box = sinon.stub()
      sinon.stub(window, "$")
      $.withArgs("#branches").returns(@combo_box)

    after ->
      window.$.restore()

    context "scm_type = SVN", ->
      beforeEach ->
        @combo_box.hide = sinon.spy()
        $.withArgs("#repository_scm_type").returns({val: -> "SVN"})

      it "should hide the branches combo box", ->
        @subject.toggle()
        assert.isTrue(@combo_box.hide.calledOnce)

    context "scm_type != SVN", ->
      beforeEach ->
        @combo_box.show = sinon.spy()
        $.withArgs("#repository_address").returns({val: -> "https://github.com/mezuro/prezento.git"})
        $.withArgs("#repository_scm_type").returns({val: -> "GIT"})
        sinon.stub(@subject, "fetch").withArgs("https://github.com/mezuro/prezento.git")

      it "should show the branches combo box", ->
        @subject.toggle()
        assert.isTrue(@combo_box.show.calledOnce)

  describe "#cancel_request", ->
    context 'request is not null', ->
      beforeEach ->
        @request = sinon.stub()
        @request.abort = sinon.spy()
        @subject.request = @request

      it 'should abort the request', ->
        @subject.cancel_request()
        assert.isTrue(@request.abort.calledOnce)
        assert.isNull(@subject.request)

  describe "#fill_options", ->
    beforeEach ->
      @el = jQuery("<select></select>")

    context 'with branches that contain master', ->
      it 'should place master first', ->
        @subject.fill_options(['dev', 'stable', 'master'], @el)

        option_values = []
        for option in @el.get(0).options
          option_values.push(option.value)

        assert.deepEqual(option_values, ['master', 'dev', 'stable'])

    context "with branches that don't contain master", ->
      it "shouldn't change anything", ->
        @subject.fill_options(['dev', 'stable', 'branch_do_daniel'], @el)

        option_values = []
        for option in @el.get(0).options
          option_values.push(option.value)

        assert.deepEqual(option_values, ['dev', 'stable', 'branch_do_daniel'])

  describe '#fetch', ->
    beforeEach ->
      @subject.cancel_request = sinon.stub()

    context 'with valid address', ->
      beforeEach ->
        sinon.stub(@subject, "fill_options")

      afterEach ->
        @subject.fill_options.restore()

      context 'with new address', ->
        beforeEach ->
          @subject.names = {}
          @address = 'https://github.com/mezuro/kalibro_processor.git'

          @select = {empty: sinon.stub()}
          $ = sinon.stub(window, "$")
          $.withArgs("#repository_branch").returns(@select)
          $.withArgs("#repository_scm_type").returns({val: -> "GIT"})
          $.get = sinon.stub().withArgs('/repository_branches', {'url': @address, 'scm_type': 'GIT'}).returns().yields({
            'branches': ['stable', 'dev', 'master']
          })

        afterEach ->
          $.restore()

        it 'should fetch the branches and fill the options', ->
          @subject.fetch(@address)
          sinon.assert.calledWith(@subject.fill_options, ['stable', 'dev', 'master'], @select)

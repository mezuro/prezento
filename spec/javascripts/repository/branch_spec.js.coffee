#= require application
#= require 'sinon'

describe "Branch#constructor", ->
  it "should construct a branch", ->
    subject = new Repository.Branch()
    subject.names.should.deep.equal({})
    assert.isNull(subject.request)

describe "toggle", ->
  @subject = new Repository.Branch()
  beforeEach ->
    @combo_box = sinon.stub()
    $ = sinon.stub(window, "$")
    $.withArgs("#branches").returns(@combo_box)
  context "scm_type = SVN", ->
    @combo_box.hide = sinon.spy()
    it "should hide the branches combo box", ->
      $.withArgs("#repository_scm_type").returns({val: -> "SVN"})
      @subject.toggle()
      assert.isTrue(@combo_box.hide.calledOnce)
  context "scm_type != SVN", ->
    @combo_box.show = sinon.spy()
      $.withArgs("#repository_address").returns({val: -> "https://github.com/mezuro/prezento.git"})
    sinon.stub(@subject, "fetch").withArgs("https://github.com/mezuro/prezento.git")
    @subject.stub = sinon.spy()
    it "should show the branches combo box", ->
      $.withArgs("#repository_scm_type").returns({val: -> "GIT"})
      @subject.toggle()
      assert.isTrue(@combo_box.show.calledOnce)

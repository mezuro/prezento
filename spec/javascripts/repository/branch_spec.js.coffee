#= require application
#= require sinon

describe "Branch#constructor", ->
  it "should construct a branch", ->
    subject = new Repository.Branch()
    subject.names.should.deep.equal({})
    assert.isNull(subject.request)

describe "toggle", ->
  before ->
    @subject = new Repository.Branch()

    @combo_box = sinon.stub()
    $ = sinon.stub(window, "$")
    $.withArgs("#branches").returns(@combo_box)

  context "scm_type = SVN", ->
    before ->
      @combo_box.hide = sinon.spy()
      $.withArgs("#repository_scm_type").returns({val: -> "SVN"})

    it "should hide the branches combo box", ->
      @subject.toggle()
      assert.isTrue(@combo_box.hide.calledOnce)

  context "scm_type != SVN", ->
    before ->
      @combo_box.show = sinon.spy()
      $.withArgs("#repository_address").returns({val: -> "https://github.com/mezuro/prezento.git"})
      $.withArgs("#repository_scm_type").returns({val: -> "GIT"})
      sinon.stub(@subject, "fetch").withArgs("https://github.com/mezuro/prezento.git")

    it "should show the branches combo box", ->
      @subject.toggle()
      assert.isTrue(@combo_box.show.calledOnce)

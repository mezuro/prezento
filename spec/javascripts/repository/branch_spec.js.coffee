#= require application

describe "Repository.Branch", ->
  beforeEach ->
    @repository_branch = new Repository.Branch()

  describe "Branch#constructor", ->
    it "should construct a branch", ->
      @repository_branch.names.should.deep.equal({})
      assert.isNull(@repository_branch.request)

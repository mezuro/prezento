#= require application

describe "Branch#constructor", ->
  it "should construct a branch", ->
    a = new Repository.Branch()
    a.names.should.deep.equal({})
    assert.isNull(a.request)

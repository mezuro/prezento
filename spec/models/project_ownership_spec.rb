require 'spec_helper'

describe ProjectOwnership do
  describe 'associations' do
    it { should belong_to(:user) }
  end
end

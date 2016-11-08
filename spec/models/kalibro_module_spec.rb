describe KalibroModule, :type => :model do
	describe 'it should include KalibroRecord' do
		let(:including_class) { Class.new { include KalibroRecord } }
	end
end
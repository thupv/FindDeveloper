
require 'rails_helper'

RSpec.describe SearchDeveloperForm do
  describe '#search' do
    context 'with no params' do
      before do
        create(:developer, email: 'abc@test.com')
        create(:developer, email: 'abd@test.com')
      end

      it 'returns no posts' do
        form = SearchDeveloperForm.new({})
        expect(form.search.size).to eq(0)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Api::DeveloperController', type: :request do
  include_context 'api'

  describe 'GET /api/developer/:developer_id' do
    before do
      @language = create(:language, code: 'vn')
      @programming_language = create(:programming_language, name: 'ruby')
      @developer = create(:developer,
                          email: 'abc2321@gmail.com',
                          languages: [@language],
                          programming_languages: [@programming_language])
    end

    context 'when developer exists' do
      before do
        get "/api/developer/#{@developer.id}"
      end

      let(:language) do
        {
          data:
            [{
              id: @language.id.to_s,
              type: 'language'
            }]
        }
      end
      let(:programming_language) do
        {
          data:
            [{
              id: @programming_language.id.to_s,
              type: 'programming_language'
            }]
        }
      end
      let(:expected_response) do
        {
          data: {
            id: @developer.id.to_s,
            type: 'developer',
            attributes: {
              email: @developer.email
            },
            relationships: {
              languages: language,
              programming_languages: programming_language
            }
          }
        }
      end
      it_behaves_like 'http_status_code_200_with_json'
    end

    context 'when the post does not exist' do
      before do
        get '/api/developer/non_exist_id'
      end

      it_behaves_like 'http_status_code_404'
    end
  end
end

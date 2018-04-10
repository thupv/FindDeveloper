require 'rails_helper'

RSpec.describe 'Api::DeveloperController', type: :request do
  include_context 'api'

  describe 'GET /api/v1/developer/:developer_id' do
    before do
      @language = create(:language)
      @programming_language = create(:programming_language)
      @developer = create(:developer,
                          languages: [@language],
                          programming_languages: [@programming_language])
    end

    context 'when developer exists' do
      before do
        get "/api/v1/developer/#{@developer.id}"
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

    context 'when the developer does not exist' do
      before do
        get '/api/v1/developer/non_existing_id'
      end

      it_behaves_like 'http_status_code_404'
    end
  end
end

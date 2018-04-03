
require 'rails_helper'

RSpec.describe SearchDeveloperForm do
  describe '#search' do
    before do
      @language1 = create(:language, code: 'vn')
      @language2 = create(:language, code: 'en')
      @language3 = create(:language, code: 'jp')

      @programming_language1 = create(:programming_language, name: 'ruby')
      @programming_language2 = create(:programming_language, name: 'js')
      @programming_language3 = create(:programming_language, name: 'c++')

      @developer1 = create(:developer,
                           email: 'abc2321@gmail.com',
                           languages: [@language1, @language3],
                           programming_languages: [@programming_language1, @programming_language3])
      @developer2 = create(:developer,
                           email: 'abc2121@gmail.com',
                           languages: [@language2],
                           programming_languages: [@programming_language2])
      @developer3 = create(:developer,
                           email: 'abc2341@gmail.com',
                           languages: [@language3],
                           programming_languages: [@programming_language3])
    end

    context 'with no params' do
      it 'returns no developers' do
        form = SearchDeveloperForm.new({})
        expect(form.search.size).to eq(0)
      end
    end

    context 'with params' do
      it 'return developer know a language' do
        form = SearchDeveloperForm.new(developers_search_form: { language_id: @language1.code })
        expect(form.search.size).to eq(1)
      end

      it 'return empty if nobody know a language' do
        form = SearchDeveloperForm.new(developers_search_form: { language_id: 'cn' })
        expect(form.search.size).to eq(0)
      end

      it 'return 2 developer know a language' do
        form = SearchDeveloperForm.new(developers_search_form: { language_id: @language3.code })
        expect(form.search.size).to eq(2)
      end

      it 'return 1 developer know a programming language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language1.name })
        expect(form.search.size).to eq(1)
      end

      it 'return 2 developer know a programming language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language3.name })
        expect(form.search.size).to eq(2)
      end

      it 'return empty if nobody know a programming language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: 'kotlin' })
        expect(form.search.size).to eq(0)
      end

      it 'return 1 developer know a programming language and a language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language1.name, language: @language1.code })
        expect(form.search.size).to eq(1)
      end

      it 'return 2 developer know a programming language and a language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language3.name, language_id: @language3.code })
        expect(form.search.size).to eq(2)
      end

      it 'return empty if nobody know both a language and a programming language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language1.name, language_id: @language2.code })
        expect(form.search.size).to eq(0)
      end

    end
  end
end

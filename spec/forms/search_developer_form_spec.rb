
require 'rails_helper'

RSpec.describe SearchDeveloperForm do
  describe '#search' do
    before do
      @developer1 = create(:developer, email: 'abc2321@gmail.com')
      @developer2 = create(:developer, email: 'abc2121@gmail.com')
      @developer3 = create(:developer, email: 'abc2341@gmail.com')
    end
    context 'with no params' do
      it 'returns no developers' do
        form = SearchDeveloperForm.new({})
        expect(form.search.size).to eq(0)
      end
    end
    context 'with params' do
      before do
        @language1 = create(:language, code: 'vn')
        @language2 = create(:language, code: 'en')
        @language3 = create(:language, code: 'jp')

        @programming_language1 = create(:programming_language, name: 'ruby')
        @programming_language2 = create(:programming_language, name: 'js')
        @programming_language3 = create(:programming_language, name: 'c++')

        @developer_language1 = create(:developer_language, developer_id: @developer1.id, language_id: @language1.id)
        @developer_language2 = create(:developer_language, developer_id: @developer2.id, language_id: @language2.id)
        @developer_language3 = create(:developer_language, developer_id: @developer3.id, language_id: @language3.id)
        @developer_language4 = create(:developer_language, developer_id: @developer1.id, language_id: @language3.id)

        @developer_programming1 = create(:developer_programming,
                                         developer_id: @developer1.id,
                                         programming_language_id: @programming_language1.id)
        @developer_programming2 = create(:developer_programming,
                                         developer_id: @developer2.id,
                                         programming_language_id: @programming_language2.id)
        @developer_programming3 = create(:developer_programming,
                                         developer_id: @developer3.id,
                                         programming_language_id: @programming_language3.id)
        @developer_programming4 = create(:developer_programming,
                                         developer_id: @developer1.id,
                                         programming_language_id: @programming_language3.id)

      end

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

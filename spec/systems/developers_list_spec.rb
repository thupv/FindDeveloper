require 'rails_helper'

RSpec.describe SearchDeveloperForm, type: :system do
  describe '#search' do
    before do
      @developer1 = create(:developer, email: 'abc232112@gmail.com')
      @developer2 = create(:developer, email: 'abc212113@gmail.com')
      @developer3 = create(:developer, email: 'abc234114@gmail.com')
    end
    context 'success navigate to list page' do
      it 'success navigated' do
        visit developer_list_path
        expect(page).to have_current_path(developer_list_path)
      end
    end
    context 'search with no params' do
      it 'returns no developers' do
        visit developer_list_path
        click_button('search')
        expect(page).to have_css('table tr', :count=>4)
      end
    end
    context 'search with params' do
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

      it 'returns 1 developer matched language' do
        visit developer_list_path
        fill_in 'developers_search_form_language_id', with: @language1.code
        click_on('search')
        expect(page).to have_css('table tr', :count=>2)
      end

      it 'returns 2 developers matched language' do
        visit developer_list_path
        fill_in 'developers_search_form_language_id', with: @language3.code
        click_on('search')
        expect(page).to have_css('table tr', :count=>3)
      end

      it 'returns 1 developers matched programming language' do
        visit developer_list_path
        fill_in 'developers_search_form_programming_language_id', with: @programming_language1.name
        click_button('search')
        expect(page).to have_css('table tr', :count=>2)
      end

      it 'returns 2 developers matched programming language' do
        visit developer_list_path
        fill_in 'developers_search_form_programming_language_id', with: @programming_language3.name
        click_on('search')
        expect(page).to have_css('table tr', :count=>3)
      end

      it 'returns 1 developers matched both language and programming language' do
        visit developer_list_path
        fill_in 'developers_search_form_language_id', with: @language1.code
        fill_in 'developers_search_form_programming_language_id', with: @programming_language1.name
        click_button('search')
        expect(page).to have_css('table tr', :count=>2)
      end

      it 'returns 2 developers matched both language and programming language' do
        visit developer_list_path
        fill_in 'developers_search_form_language_id', with: @language3.code
        fill_in 'developers_search_form_programming_language_id', with: @programming_language3.name
        click_on('search')
        expect(page).to have_css('table tr', :count=>3)
      end

      it 'returns 0 developers matched' do
        visit developer_list_path
        fill_in 'developers_search_form_language_id', with: 'wrong'
        fill_in 'developers_search_form_programming_language_id', with: 'wrong'
        click_on('search')
        expect(page).to have_css('table tr', :count=>1)
      end
      
    end
  end

end
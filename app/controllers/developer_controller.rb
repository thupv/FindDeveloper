class DeveloperController < ApplicationController
  def list
    @developers_search_form = SearchDeveloperForm.new(list_params)
    @developers = @developers_search_form.search
  end

  def list_params
    params.permit(developers_search_form: SearchDeveloperForm::FORM_FIELDS)
  end
end

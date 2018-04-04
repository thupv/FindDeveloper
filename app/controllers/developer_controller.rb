class DeveloperController < ApplicationController
  def list
    @form = SearchDeveloperForm.new(list_params)
    @developers = @form.search
  end

  def list_params
    params.permit(developers_search_form: SearchDeveloperForm::FORM_FIELDS)
  end
end

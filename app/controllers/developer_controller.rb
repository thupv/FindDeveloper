class DeveloperController < ApplicationController
  def list
    @form = SearchDeveloperForm.new(permitted_params)
    @developers = @form.search
  end

  def permitted_params
    params.permit(developers_search_form: SearchDeveloperForm::FORM_FIELDS)
  end
end

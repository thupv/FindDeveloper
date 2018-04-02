class SearchDeveloperForm
  include Virtus.model
  include ActiveModel::Model

# frozen_string_literal: true

  FORM_FIELDS = %i[
    language
    programming_language
  ].freeze

  FORM_FIELDS.each do |f|
    attribute f, String
  end

  def initialize(params)
    @developers_search_form = params[:developers_search_form] || {}
    FORM_FIELDS.each { |f| send("#{f}=", @developers_search_form[f]) }
  end

  def search
    return Developer.none if @developers_search_form.empty?
  end


end
class SearchDeveloperForm
  include Virtus.model
  include ActiveModel::Model

  FORM_FIELDS = %i[
    language_id
    programming_language_id
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

    query = Developer.includes(:programming_languages).includes(:languages).includes(:developer_programmings).includes(:developer_languages)
    query = query.joins(:programming_languages).where(programming_languages: { name: programming_language_id}) if programming_language_id.present?
    query = query.joins(:languages).where(languages: { code: language_id }) if language_id.present?
    query
  end


end
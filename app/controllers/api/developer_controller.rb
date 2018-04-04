# frozen_string_literal: true

module Api
  class DeveloperController < BaseController
    before_action :set_developer, only: %i[show]

    def show
      # rubocop:disable Style/GuardClause
      if stale?(last_modified: @developer.updated_at.utc)
        cache_options = { compress: true, expires_in: 24.hours, race_condition_ttl: 10 }
        Rails.cache.fetch("#{@developer.cache_key}/#{__method__}", cache_options) do
          render json: DeveloperSerializer.new(@developer).serialized_json
        end
      end
      # rubocop:enable Style/GuardClause
    end

    private

    def set_developer
      @developer = Developer.includes(:developer_languages, :developer_programmings).find(params[:id])
    end
  end
end

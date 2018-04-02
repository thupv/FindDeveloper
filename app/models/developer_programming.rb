class DeveloperProgramming < ApplicationRecord
  belongs_to :developer, inverse_of: :developer_programmings
  belongs_to :programming_language, inverse_of: :developer_programmings
end

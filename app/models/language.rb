class Language < ApplicationRecord
  has_many :developer_languages, dependent: :destroy
  has_many :developer, through: :developer_languages

  validates :code, presence: true, uniqueness: true
end

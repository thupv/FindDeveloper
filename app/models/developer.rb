class Developer < ApplicationRecord
  has_many :developer_languages, dependent: :destroy
  has_many :languages, through: :developer_languages

  has_many :developer_programmings, dependent: :destroy
  has_many :programming_languages, through: :developer_programmings

  validates :email, presence: true, uniquess: true
end

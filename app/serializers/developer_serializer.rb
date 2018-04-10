class DeveloperSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email

  has_many :languages
  has_many :programming_languages
end

namespace :dev do
  require 'factory_bot_rails'
  require 'faker'

  desc 'Generate test data'
  task :generate_data, [:developers_num, :language_num, :programming_language_num] => :environment do |_, args|
    set_args(args)

    developers = []
    languages = []
    programming_languages = []

    @args[:developers_num].times do
      email = loop do
        email = Faker::Internet.email
        break email unless Developer.exists?(email: email)
      end

      developers << FactoryBot.create(:developer, email: email)
    end

    @args[:language_num].times do
      language_code = loop do
        language_code = Faker::Address.country_code
        break language_code unless Language.exists?(code: language_code)
      end

      languages << FactoryBot.create(:language, code: language_code)
    end

    @args[:programming_language_num].times do
      programming_language_name = loop do
        programming_language_name = Faker::ProgrammingLanguage.name
        break programming_language_name unless ProgrammingLanguage.exists?(name: programming_language_name)
      end

      programming_languages << FactoryBot.create(:programming_language, name: programming_language_name)
    end


  end
end


def set_args(args)
  @args = {}
  @args[:developers_num] = (args[:developers_num] || 10).to_i
  @args[:language_num] = (args[:language_num] || 5).to_i
  @args[:programming_language_num] = (args[:programming_language_num] || 10).to_i
end
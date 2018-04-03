namespace :dev do
  require 'factory_bot_rails'
  require 'faker'

  desc 'Generate test data'
  task :generate_data, %i[developers_num languages_num programming_languages_num] => :environment do |_, args|
    process_args(args)

    @list_developer = []
    @list_language = []
    @list_programming_language = []

    puts '========Start generate test data, params========'
    puts 'Number of developer: ' + @args[:developers_num].to_s
    puts 'Number of language: ' + @args[:languages_num].to_s
    puts 'Number of programming language: ' + @args[:programming_languages_num].to_s

    create_language
    create_programming_language
    create_developer

    puts 'Created: ' +
           @list_developer.length.to_s + ' Developer, ' +
           @list_language.length.to_s + ' Languages, ' +
           @list_programming_language.length.to_s + ' Programming languages'
  end
end

def process_args(args)
  @args = {}
  @args[:developers_num] = (args[:developers_num] || 100).to_i
  @args[:languages_num] = (args[:languages_num] || 10).to_i
  @args[:programming_languages_num] = (args[:programming_languages_num] || 10).to_i
end

def create_language
  @args[:languages_num].times do
    language_code = loop do
      code = Faker::Address.country_code
      break code unless Language.exists?(code: code)
    end
    language = FactoryBot.create(:language, code: language_code)
    puts 'Created a language: ' + language.code
    @list_language << language
  end
end

def create_programming_language
  @args[:programming_languages_num].times do
    programming_language_name = loop do
      name = Faker::ProgrammingLanguage.name
      break name unless ProgrammingLanguage.exists?(name: name)
    end
    programming_language = FactoryBot.create(:programming_language, name: programming_language_name)
    puts 'Created a programming language: ' + programming_language.name
    @list_programming_language << programming_language
  end
end

def create_developer
  @args[:developers_num].times do
    email = loop do
      email = Faker::Internet.email
      break email unless Developer.exists?(email: email)
    end

    developer = FactoryBot.create(:developer,
                                  email: email,
                                  languages: @list_language.sample(1 + rand(@list_language.count)),
                                  programming_languages: @list_programming_language.sample(1 + rand(@list_programming_language.count)))
    puts 'Created a developer: ' + developer.email
    @list_developer << developer
  end
end
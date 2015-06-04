FactoryGirl.define do
  factory :application, class: Moxie::Application do
    name 'myapp'
    repo 'git@github.com:mycompany/myapp.git'
    initialize_with { new(attributes) }
  end
end


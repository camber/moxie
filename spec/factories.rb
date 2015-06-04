FactoryGirl.define do
  factory :application, class: Moxie::Application do
    name 'myapp'
    repo 'git@github.com:mycompany/myapp.git'
    initialize_with { new(attributes) }
  end

  factory :build, class: Moxie::Build do
    id          { Moxie::Generate.id }
    version     { Moxie::Generate.version }
    app         'myapp'
    branch      'master'
    status      'pending'
    initialize_with { new(attributes) }
  end
end


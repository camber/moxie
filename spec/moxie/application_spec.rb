require 'spec_helper'

module Moxie
  describe Application, "#name" do
    it "returns its name" do
      application = build(:application, name: 'myapp')
      expect(application.name).to eq 'myapp'
    end
  end

  describe Application, "#id" do
    it "returns its name" do
      application = build(:application, name: 'myapp')
      expect(application.id).to eq 'myapp'
    end
  end

  describe Application, "#repo" do
    it "returns its repo" do
      application = build(:application, repo: 'git@github.com:mycompany/myapp.git')
      expect(application.repo).to eq 'git@github.com:mycompany/myapp.git'
    end
  end

  describe Application, "#build_ids" do
    it "returns its build ids" do
      application = build(:application, name: 123)
      ids_store = double(to_a: [1,2])
      expect(Store).to receive(:set).with('application:123:builds').and_return(ids_store)
      expect(application.build_ids).to eq [1,2]
    end
  end

  describe Application, "#builds" do
    it "returns its builds" do
      build1, build2 = double, double
      application = build(:application)
      allow(application).to receive(:build_ids).and_return([1,2])
      expect(Build).to receive(:find).with([1,2]).and_return([build1, build2])
      expect(application.builds).to eq [build1, build2]
    end
  end
end

module Moxie
  describe Application, ".create" do
    it "creates and returns a new application" do
      object_store = double
      allow(Store).to receive(:object).with('application:myapp').and_return(object_store)
      expect(object_store).to receive(:save).with({ 'name' => 'myapp', 'repo' => 'git@github.com:mycompany/myapp.git' })

      ids_store = double(to_a: [])
      allow(Store).to receive(:set).with('applications').and_return(ids_store)
      expect(ids_store).to receive(:add).with('myapp')

      attrs = attributes_for(:application).merge({
        name: 'myapp',
        repo: 'git@github.com:mycompany/myapp.git'
      })

      application = Application.create(attrs)

      expect(application.name).to eql 'myapp'
      expect(application.repo).to eql 'git@github.com:mycompany/myapp.git'
    end
  end

  describe Application, ".update" do
    it "updates the application" do
      attrs = attributes_for(:application).merge({
        name: 'myapp',
        repo: 'oldrepo'
      })

      application = Application.create(attrs)
      Application.update('myapp', {repo: 'newrepo'})

      application = Application.find(application.id)
      expect(application.repo).to eql 'newrepo'
    end
  end

  describe Application, ".delete" do
    it "deletes the application" do
      application = double(id: 'myapp')
      allow(Application).to receive(:find).with('myapp').and_return(application)

      object_store = double
      allow(Store).to receive(:object).with('application:myapp').and_return(object_store)
      expect(object_store).to receive(:delete)

      ids_store = double
      allow(Store).to receive(:set).with('applications').and_return(ids_store)
      expect(ids_store).to receive(:remove).with('myapp')

      Application.delete('myapp')
    end
  end

  describe Application, ".exists?" do
    it "returns true when an application with the same name exists" do
      allow(Application).to receive(:ids) { ['a', 'b', 'c'] }
      expect(Application.exists?('a')).to eql true
      expect(Application.exists?('b')).to eql true
      expect(Application.exists?('c')).to eql true
    end

    it "returns false when an application with the same name does not exist" do
      allow(Application).to receive(:ids) { ['a', 'b', 'c'] }
      expect(Application.exists?('d')).to eql false
      expect(Application.exists?('e')).to eql false
      expect(Application.exists?('f')).to eql false
    end
  end
end


require 'spec_helper'

module Moxie
  describe Build, '.create' do
    it "creates and returns a new build" do
      allow(Generate).to receive(:id).and_return(123)
      allow(Generate).to receive(:version).and_return('20150604T112221')

      hash = {
        'id'          => 123,
        'version'     => '20150604T112221',
        'app' => 'myapp',
        'branch'      => 'master',
        'status'      => 'pending'
      }

      application = double(id: 'myapp')
      allow(Application).to receive(:find).with('myapp').and_return(application)

      object_store = double
      allow(Store).to receive(:object).with('build:123').and_return(object_store)
      expect(object_store).to receive(:save).with(hash)

      ids_store = double(to_a: [])
      allow(Store).to receive(:set).with('builds').and_return(ids_store)
      expect(ids_store).to receive(:add).with(123)

      ids_store = double(to_a: [])
      allow(Store).to receive(:set).with('application:myapp:builds').and_return(ids_store)
      expect(ids_store).to receive(:add).with(123)

      attrs = attributes_for(:build).merge({
        app: 'myapp',
        branch: 'master'
      })

      build = Build.create(attrs)

      expect(build.id).to eql 123
      expect(build.version).to eql '20150604T112221'
      expect(build.app).to eql 'myapp'
      expect(build.branch).to eql 'master'
    end
  end

  describe Build, '#application' do
    it "returns its application" do
      application = double
      expect(Application).to receive(:find).with('myapp').and_return(application)
      build = build(:build, app: 'myapp')
      expect(build.application).to eql application
    end
  end

  describe Build, '#repo' do
    it "returns its application's repo" do
      application = double(repo: 'myrepo')
      build = build(:build)
      allow(build).to receive(:application).and_return(application)
      expect(build.repo).to eql 'myrepo'
    end
  end
end


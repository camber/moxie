require 'spec_helper'

module Moxie
  describe Transforms, "Slug" do
    it "normalizes the value to a slug-suitable string" do
      slug = Transforms::Slug.call('  My Application.123 ')
      expect(slug).to eq 'my-application.123'
    end
  end
end


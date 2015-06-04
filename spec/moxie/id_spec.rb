require 'spec_helper'

module Moxie
  describe ID, ".generate" do
    it "returns a new id of appropriate length" do
      id = ID.generate
      expect(id).to be_a String
      expect(id.length).to eql 8
    end

    it "returns random id" do
      id1 = ID.generate
      id2 = ID.generate
      id3 = ID.generate
      expect([id1, id2, id3].uniq.length).to eql 3
    end
  end
end


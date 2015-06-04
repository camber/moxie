require 'spec_helper'

module Moxie
  describe Generate, ".id" do
    it "returns a new id of appropriate length" do
      id = Generate.id
      expect(id).to be_a String
      expect(id.length).to eql 8
    end

    it "returns random id" do
      id1 = Generate.id
      id2 = Generate.id
      id3 = Generate.id
      expect([id1, id2, id3].uniq.length).to eql 3
    end
  end

  describe Generate, ".version" do
    it "returns a timestamp suitable for use as a version" do
      allow(Time).to receive(:now).and_return(Time.at(1433438611))
      expect(Generate.version).to eql '20150604T112331'
    end
  end
end


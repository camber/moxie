require 'spec_helper'

module Moxie
  describe Store, ".set" do
    it "returns a Set for the given key" do
      set = double
      expect(Store::Set).to receive(:new).with('mykey').and_return(set)
      expect(Store.set('mykey')).to eql set
    end
  end

  describe Store, ".object" do
    it "returns a Object for the given key" do
      object = double
      expect(Store::Object).to receive(:new).with('mykey').and_return(object)
      expect(Store.object('mykey')).to eql object
    end
  end
end

module Moxie
  class Store
    describe Set, ".to_a" do
      it "returns a set of ids for the key" do
        expect(Moxie.redis).to receive(:smembers).with('mykey').and_return([1,2,3])
        expect(Set.new('mykey').to_a).to eql [1,2,3]
      end
    end

    describe Set, ".add" do
      it "adds the value to the key's set" do
        expect(Moxie.redis).to receive(:sadd).with('mykey', 567)
        Set.new('mykey').add(567)
      end
    end

    describe Set, ".remove" do
      it "removes the value from the key's set" do
        expect(Moxie.redis).to receive(:srem).with('mykey', 567)
        Set.new('mykey').remove(567)
      end
    end
  end
end

module Moxie
  class Store
    describe Object, ".to_hash" do
      it "returns a hash for the key" do
        json = %q[{"name":"Casey","age":26}]
        hash = { 'name' => 'Casey', 'age' => 26 }
        expect(Moxie.redis).to receive(:get).with("mykey").and_return(json)
        expect(Object.new('mykey').to_hash).to eql(hash)
      end
    end

    describe Object, ".save" do
      it "saves the hash to the key" do
        json = %q[{"name":"Casey","age":26}]
        hash = { 'name' => 'Casey', 'age' => 26 }
        expect(Moxie.redis).to receive(:set).with("mykey", json)
        Object.new('mykey').save(hash)
      end
    end

    describe Object, ".delete" do
      it "deletes the key" do
        expect(Moxie.redis).to receive(:del).with("mykey")
        Object.new('mykey').delete
      end
    end
  end
end


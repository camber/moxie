require 'spec_helper'

module Moxie
  class Widget
    extend Finders
    keyspace 'widget'
  end

  describe Finders, ".ids" do
    it "returns an array of all widget ids" do
      ids_store = double(to_a: [1,2])
      expect(Store).to receive(:set).with('widgets').and_return(ids_store)
      expect(Widget.ids).to eql([1,2])
    end
  end

  describe Finders, ".all" do
    it "returns all widgets" do
      widget1, widget2 = double, double
      expect(Widget).to receive(:ids).and_return([1,2])
      expect(Widget).to receive(:find).with(1).and_return(widget1)
      expect(Widget).to receive(:find).with(2).and_return(widget2)
      expect(Widget.all).to eql [widget1, widget2]
    end
  end

  describe Finders, ".find" do
    context "when a single id is provided" do
      it "returns the result of .find_one with the provided id" do
        widget = double
        expect(Widget).to receive(:find_one).with(123).and_return(widget)
        expect(Widget.find(123)).to eql widget
      end
    end

    context "when an array of ids is provided" do
      it "returns the result of .find_multiple with the provided ids" do
        widget1, widget2 = double, double
        expect(Widget).to receive(:find_multiple).with([1,2]).and_return([widget1, widget2])
        expect(Widget.find([1,2])).to eql [widget1, widget2]
      end
    end
  end

  describe Finders, ".find_one" do
    it "returns the widget with the provided id" do
      widget = double
      hash = {id: 123}
      object_store = double(to_hash: hash)
      expect(Store).to receive(:object).with("widget:123").and_return(object_store)
      expect(Widget).to receive(:new).with(hash).and_return(widget)
      expect(Widget.find_one(123)).to eql widget
    end
  end

  describe Finders, ".find_multiple" do
    it "returns an array of widgets with the provided ids" do
      widget1, widget2 = double, double
      expect(Widget).to receive(:find_one).with(1).and_return(widget1)
      expect(Widget).to receive(:find_one).with(2).and_return(widget2)
      expect(Widget.find_multiple([1,2])).to eql [widget1, widget2]
    end
  end

end


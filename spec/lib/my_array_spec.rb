# frozen_string_literal: true

require 'rails_helper'
require "#{Rails.root}/lib/my_array"

describe MyArray do
  let(:instance) { MyArray[1, 2, 3] }

  describe "#my_length" do
    context  do
      it "return" do
        expect(instance.my_length)
        .to eq(3)
      end
    end
  end

  describe "#my_each" do
    context "with block" do
      it "yields items" do
        yielded_values = []
        instance.my_each { |e| yielded_values << e }
        expect(yielded_values).to eq([1, 2, 3])
      end
      it "returns self" do
        expect(instance.my_each {})
        .to eq(instance)
      end
    end

    context "without block" do
      it "returns enumerator" do
        expect(instance.my_each )
        .to be_a(Enumerator)
      end
    end
  end

  describe "#my_map" do
    context "with multiplied by 2 blok" do
      it "return new array" do
        expect(instance.my_map { |e|  e * 2 })
        .to eq(MyArray[2, 4, 6])
      end
    end
  end

  describe "#my_select" do
    context "selects items more than 2" do
      it "return items if true" do
        expect(instance.my_select { |e| e > 2 }).to eq(MyArray[3])
      end
    end
  end

  describe "#my_find" do
    context "finds item that more than 1" do
      it "return one true item" do
        expect(instance.my_find { |e| e > 1 })
        .to eq(MyArray[2])
      end
    end
  end

  describe "#my_uniq" do
    context "without block" do
      let(:instance) { MyArray[1, 1, 2, 2, 3] }
      it "returns a new array by removing duplicate values" do
        expect(instance.my_uniq)
        .to eq(MyArray[1, 2, 3])
      end
    end

    context "with block" do
      let(:instance_for_block) { MyArray[[1, nil], [1, nil], [2,nil]] }
      it "uses the return value of the block for comparison" do
        expect(instance_for_block.my_uniq {|s| s.first })
        .to eq(MyArray[[1, nil],[2, nil]])
      end
    end
  end

  describe "#my_uniq!" do
    let(:instance) { MyArray[1, 1, 2, 2, 3] }
    context "without block" do
      it "returns a new instance by removing duplicate values in array" do
        expect(instance.my_uniq!)
        .to eq(MyArray[1, 2, 3])
      end
    end
    context "with block" do
      let(:instance_for_block) { MyArray[[1, nil], [1, nil], [2,nil]] }
      it "uses the return value of the block for comparison" do
        expect(instance_for_block.my_uniq! {|s| s.first })
        .to eq(MyArray[[1, nil],[2, nil]])
      end
    end
  end

  describe "#my_reject" do
    context "selects items more than 2" do
      it "return items if true" do
        expect(instance.my_reject { |e| e > 2 })
        .to eq(MyArray[1, 2])
      end
    end
  end

  describe '.[]' do
    let(:instance) { MyArray[1, 2] }
    context "creates instanse with []" do
      it "returns new instance" do
        expect(instance.array)
        .to eq([1, 2])
      end
    end
  end
end

require 'spec_helper'

describe Gitlab::CLI::Helpers do
  describe ".valid_command?" do
    it "should return true when command is valid" do
      expect(Gitlab::CLI::Helpers.valid_command? 'merge_requests').to be_truthy
    end
    it "should return false when command is NOT valid" do
      expect(Gitlab::CLI::Helpers.valid_command? 'mmmmmerge_requests').to be_falsy
    end
  end
  describe ".symbolize_keys" do
    context "when input is a Hash" do
      it "should return a Hash with symbols for keys" do
        hash = {'key1' => 'val1', 'key2' => 'val2'}
        symbolized_hash = Gitlab::CLI::Helpers.symbolize_keys(hash)
        expect(symbolized_hash).to eq({key1: 'val1', key2: 'val2'})
      end
    end
    context "when input is NOT a Hash" do
      it "should return input untouched" do
        array = [1, 2, 3]
        new_array = Gitlab::CLI::Helpers.symbolize_keys(array) 
        expect(new_array).to eq([1, 2, 3])
      end
    end
  end

  describe ".yaml_load_arguments!" do
    context "when arguments are YAML" do
      it "should return Ruby objects" do
        arguments = ["{foo: bar, sna: fu}"] 
        Gitlab::CLI::Helpers.yaml_load_arguments! arguments
        expect(arguments).to eq([{'foo' => 'bar', 'sna' => 'fu'}])
      end
    end

    context "when input is NOT valid YAML" do
      it "should raise" do
        ruby_array = [1, 2, 3, 4]
        expect { Gitlab::CLI::Helpers.yaml_load_arguments! ruby_array}.to raise_exception
      end
    end
  end

end

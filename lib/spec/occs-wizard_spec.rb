require 'rspec'
require 'rspec/its'
require '../lib/occs-wizard'

describe Wizard do

  #create an instance of the Wizard class before running each test
  before(:each) do
    @wizard = Wizard.new
  end

  context "Check variables" do

    # extension id
    it "should be at least 36 characters long" do
      @wizard.extension_id = "83be3a58-9138-4cbe-884d-cc52b41b8d5b"
      expect(@wizard.extension_id.size).to eq(36)
    end

    it "should be a String" do
      ext = "83be3a58-9138-4cbe-884d-cc52b41b8d5b"
      @wizard.set_extension_id(ext)
      expect(@wizard.extension_id).to be_an_instance_of(String)
    end

    it "should throw if the argument is not a String" do
      ext = 123456789012345678901234567890123456
      expect { @wizard.set_extension_id(ext) }.to raise_error(ArgumentError)
    end

    # developer id
    it 'should throw if the value passed is empty' do
      expect { @wizard.set_developer_id("") }.to raise_error(ArgumentError)
    end

    it 'the argument passed should have the same size as a Fixnum' do
      dev_id = 12345678
      @wizard.set_developer_id("12345678")
      expect(@wizard.get_developer_id.size).to eq(dev_id.to_s.size)
    end

    # creation date
    it 'should return the current date' do
      today = @wizard.set_created_at
      expect(@wizard.get_created_at).to eq(today)
    end

    # extension name
    it 'should throw if the extension name is empty' do
      ext_name = ""
      expect { @wizard.set_extension_name(ext_name) }.to raise_error(ArgumentError)
    end

    it 'should not contains empty spaces and it should be all lowercases' do
      string = "Extension Name"
      expect(@wizard.set_extension_name(string)).to eq("extensionname")
    end

  end
end
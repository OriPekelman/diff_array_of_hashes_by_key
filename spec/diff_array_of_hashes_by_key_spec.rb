require "spec_helper"
RSpec.describe DiffArrayOfHashesByKey do
  before(:each) do
    @key="id"
    @timestamp = nil
    @a= [
      {"id"=>"1", "foo"=>"bar"},
      {"id"=>"2", "bar"=>"baz"},
      {"id"=>"3", "foobar"=>"to_be_deleted"}
    ]
    @b= [
      {"id"=>"1", "foo"=>"bar"},
      {"id"=>"2", "bar"=>"changed"},
      {"id"=>"4", "foobar"=>"created"}
    ]
  end
  
  it "has a version number" do
    expect(DiffArrayOfHashesByKey::VERSION).not_to be nil
  end
  it "has diff method" do
    expect(@a).to respond_to(:diff) 
  end

  it "has changes" do
    expect(@a.changed(@b,key: @key, timestamp: @timestamp)).to eq([{"id"=>"2", "bar"=>"changed"}])
  end
  it "has deletes" do
    expect(@a.deleted(@b,key: @key, timestamp: @timestamp)).to eq([{"id"=>"3", "foobar"=>"to_be_deleted"}])
  end
  it "has creations" do
    expect(@a.created(@b,key: @key, timestamp: @timestamp)).to eq([{"id"=>"4", "foobar"=>"created"}])
  end
  it "has diff" do
    diff = {
      :changed => [{"id"=>"2", "bar"=>"changed"}],
      :created => [{"id"=>"4", "foobar"=>"created"}],
      :deleted => [{"id"=>"3", "foobar"=>"to_be_deleted"}]
    }
    expect(@a.diff(@b,key: @key, timestamp: @timestamp)).to eq(diff)
  end
  it "adds timestamps" do
    @timestamp = 1499367480
    diff = {
      :changed => [{"id"=>"2", "bar"=>"changed", "timestamp"=>1499367480}],
      :created => [{"id"=>"4", "foobar"=>"created", "timestamp"=>1499367480}],
      :deleted => [{"id"=>"3", "foobar"=>"to_be_deleted", "timestamp"=>1499367480}]
    }
    expect(@a.diff(@b, key: @key, timestamp: @timestamp)).to eq(diff)
  end
end

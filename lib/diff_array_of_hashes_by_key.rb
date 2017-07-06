require "diff_array_of_hashes_by_key/version"
require "pry"

module DiffArrayOfHashesByKey
  
  def created(array_to_compare, key: "id", timestamp: nil)
    add_time_stamp(array_to_compare.select{|v| (array_to_compare.map{|x| x[key]} - self.map{|x| x[key]}).include? v[key]}, timestamp)
  end
  
  def changed(array_to_compare, key: "id", timestamp: nil)
    add_time_stamp(array_to_compare.reject{|v| v == self.select{|x|x[key]==v[key]}[0] || []} - self.created(array_to_compare), timestamp)
  end
  
  def deleted(array_to_compare, key: "id", timestamp: nil)
    add_time_stamp(self.select{|v| (self.map{|x| x[key]} - array_to_compare.map{|x| x[key]}).include? v[key]}, timestamp)
  end
  
  def diff(array_to_compare, key: "id", timestamp: nil)
    {created: created(array_to_compare, key: key, timestamp: timestamp), changed: changed(array_to_compare, key: key, timestamp: timestamp),  deleted: deleted(array_to_compare, key: key, timestamp: timestamp)}
  end
  
  def add_time_stamp(hash, timestamp)
    hash = hash.map{|x| x["timestamp"] = timestamp ; x} unless timestamp.nil?
    hash
  end
end

class Array
  include DiffArrayOfHashesByKey
end

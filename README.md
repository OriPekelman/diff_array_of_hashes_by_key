# Diff Array Of Hashes By Key

This is a simple ruby diff of arrays of hashes. The hashes are assumed to have a unique key.
It allows to see what hashes were created, what were modified and what were deleted from the array.

What is this useful for ?  imagine you get a static daily export of data. But what you really want is a diff between yesterday and today, so you can emit change events..?

You load the first and the second into an array, now you can call `.changed` `.created` `.deleted` and `.diff` on the first and pass it the second array. tada.

You can optionally set  the name of the "primary" key, and add a timestamp ()

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'diff_array_of_hashes_by_key'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install diff_array_of_hashes_by_key

## Usage

This gem monkey-patches Array, because I am old style

```ruby
    require 'diff_array_of_hashes_by_key'

    a= [
      {"id"=>"1", "foo"=>"bar"},
      {"id"=>"2", "bar"=>"baz"},
      {"id"=>"3", "foobar"=>"to_be_deleted"}
    ]
    
    b= [
      {"id"=>"1", "foo"=>"bar"},
      {"id"=>"2", "bar"=>"changed"},
      {"id"=>"4", "foobar"=>"created"}
    ]
    
    a.diff(b, key: "id")
```

      => {:created=>[{"id"=>"4", "foobar"=>"created"}], :changed=>[{"id"=>"2", "bar"=>"changed"}], :deleted=>[{"id"=>"1", "foo"=>"bar"}, {"id"=>"3", "foobar"=>"to_be_deleted"}]}
      
```ruby
    a.diff(b, key: "id", timestamp: Time.now())
```

    => {:created=>[{"id"=>"4", "foobar"=>"created", "timestamp"=>2017-07-06 21:13:32 +0200}], :changed=>[], :deleted=>[{"id"=>"3", "foobar"=>"to_be_deleted", "timestamp"=>2017-07-06 21:13:32 +0200}]}    

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/oripekelman/diff_array_of_hashes_by_key.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# Xpungr

Xpungr is a Ruby gem designed to work with Rails, ActiveRecord, and Mongoid to replace paranoia and soft-delete gems with an archival system which removes the data from your primary database and stores it in a MongoDB collection.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xpungr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xpungr

## Usage

First, you need a Mongoid model to house your archived records. This is easily done with a Rails generator, where you specify the name of the model file you want to create.

```
dave:~xpungr$ rails g xpungr:archive user
      create  app/models/archived/user.rb
dave:~xpungr$
```

Next, you need to include the Xpungr module in your ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  include Xpungr::Model
end
```

Next, setup archiving using the ```xpunge``` method, which has the following arguments:

* **primary_key:** required; the name of the primary key field of the model
* **to:** required; defines the name of the Mongoid model which will house your archived records; defaults to 'Archived::<Model Class Name>'
* **cascade:** optional; if there are records related to this model that should also be archived as well, they can be defined here in a simple hash where the key is the name of the related model in snake case and the value is the foreign key in that model that corresponds with the primary key of this model
* **block_deletes:** optional; if set to true, will override ActiveRecord methods for deleting and trigger an exception; do not use this in production as it is designed to allow you, in development, to identify and remove uses of traditional deleting vs the new archiving

```ruby
class User < ActiveRecord::Base
  include Xpungr::Model

  xpunge to: Archived::User, primary_key: :user_id, block_deletes: true, cascade: { order: :user_id, thing: :user_id, payment: :payee_id }
end
```
And now, when you want to delete or destroy a record, you should call the 'archive!' method instead:

```ruby
user = User.find 21
user.archive!
```

If you want to search and display your archived records, you can fetch them via the associated Mongoid model. To restore from the archive:

```ruby
User.restore(21)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/xpungr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Xpungr project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/xpungr/blob/master/CODE_OF_CONDUCT.md).

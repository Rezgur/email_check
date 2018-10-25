# EmailCheck

## Description
This was originally built by [Darshan Patil](https://github.com/dapatil/email_check) but has been modified to rely on a more updated list of disposable domains.  
This gem provides a robust mechanism to validate email addresses and restrict account creation to corporate email accounts.

This gem also ships with a data-set of [disposable](http://en.wikipedia.org/wiki/Disposable_email_address)
email domains which are used for validation checks.

You can also block certain usernames from creating accounts. Examples: admin, root

### Validation mechanisms
- Uses the mail gem. 
- Checks the domain's MX record
- Validate against a blacklist of domains
- Validates against a list of disposable email providers
- A whitelist can be used to override these checks

## Installation
Add this line to your application's Gemfile:
```ruby
# if you don't already have it:
git_source(:github) { |repo| "https://github.com/#{repo}.git" }


gem "email_check", github: 'Rezgur/email_check'
```

## Usage
### Use with ActiveModel
To validate just the format of the email address
```ruby
class User < ActiveRecord::Base
  validates_email :email
end
```
To validate that the domain has a MX record:
```ruby
validates_email :email, check_mx: true
```
To validate that the email is not from a disposable email provider:
```ruby
validates_email :email, not_disposable:true
```
To validate that the domain is not blacklisted:
```ruby
validates_email :email, not_blacklisted:true
```

To validate that the username is not blocked
```ruby
validates_email :email, block_special_usernames:true
```

Everything together:
```ruby
validates_email :email,
    check_mx: true, 
    not_disposable:true, 
    not_blacklisted:true,
    block_special_usernames:true,
    message: "Please register with your corporate email"
```

To turn everything on by default, you can use the validates_email_strictness helper. 
     
```ruby
# Example above
validates_email_strictness :email
```

### Modifying the inbuilt lists
The lists are exposed as assignable arrays so you can customize them or load whatever data you please.

Add a config/intializers/email_check.rb
```ruby
# Set disposable email domains
EmailCheck.disposable_email_domains = ['freemail.org']
# Append to the whitelist
EmailCheck.whitelisted_domains << 'gmail.com'
EmailCheck.free_email_domains << 'thenewgmail.com'
# Setting a domain in the blacklist will also blacklist all subdomains
EmailCheck.blacklisted_domains << 'lvh.me'
# Block the 'anonymous' username for all domains
EmailCheck.blocked_usernames << 'anonymous'
```

## Requirements
This gem is tested with Rails 5.0+. Ruby versions tested:
- Ruby 2.5.1

Rails versions tested:
- Rails 5.2.1

## Credits
- This code is based upon: [dapatil/email_check](https://github.com/dapatil/email_check) which is heavily based upon [lisinge/valid_email2](https://github.com/lisinge/valid_email2) 
- Disposable email list via: [martenson/disposable-email-domains](https://github.com/martenson/disposable-email-domains)


## Contributing

1. Fork it ( https://github.com/Rezgur/email_check/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

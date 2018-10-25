require "email_check/version"
require "email_check/email_validator"
require 'email_check/helper_methods'

module EmailCheck
  # Load the data
  @@disposable_email_domains ||= File.read(File.expand_path('../../vendor/disposable_email_blocklist.conf',__FILE__)).split('\n')
  @@blacklisted_domains ||= File.read(File.expand_path("../../vendor/blacklist.conf", __FILE__)).split('\n')
  @@blocked_usernames ||= File.read(File.expand_path("../../vendor/blocked_usernames.conf", __FILE__)).split('\n')

  # Disposable email providers
  def self.disposable_email_domains
    @@disposable_email_domains ||= []
  end

  def self.disposable_email_domains=(list)
    @@disposable_email_domains = list
  end

  # Blacklist - This will also check for subdomains
  def self.blacklisted_domains
    @@blacklisted_domains ||= []
  end

  def self.blacklisted_domains=(list)
    @@blacklisted_domains = list
  end

  # Whitelist
  def self.whitelisted_domains
    @@whitelisted_domains ||= []
  end

  def self.whitelisted_domains=(list)
    @@whitelisted_domains = list
  end

  def self.blocked_usernames
    @@blocked_usernames ||= []
  end

  def self.blocked_usernames=(list)
    @@blocked_usernames = list
  end
end

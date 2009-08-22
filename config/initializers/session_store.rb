# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_flashmobstream_session',
  :secret      => '93266b6ef257c3f6f96cda4d31bc345942d9ae639fa231da275371eb485030f2e0778f141b3bc56a7d772767adfcbb7349f7346a21fd1ae5982b63b92e7d2a53'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

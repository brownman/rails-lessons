# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_coconut_session',
  :secret      => 'd9f4e7f3e015de1b72d81f5f23bb239bde7f447ca0be47185ad50c5a2c62349b38eb7ec75df16ae7038f909c41c8872151c07a6464f11468985e5b7a1337a8a4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

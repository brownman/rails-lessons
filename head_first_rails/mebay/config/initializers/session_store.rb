# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mebay_session',
  :secret      => 'c2a4d47f1e09b02076924c3acf22688b711df86c3de3850cf2f9ca6cecff56f40048e04adc951fa55f4a04c6743085fe2bd813bf553291b86caf487b45c1007e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_training_session',
  :secret      => '932ed16fb588f62adacacbfc0d77f39aac40c2406a671893edcea72379293ea0cab998e12b51b758aa80e87ecfe2d4d33b1dfe81dd87a0ad7375b017a4ab984e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

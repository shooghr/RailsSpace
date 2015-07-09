# Load the Rails application.
require File.expand_path('../application', __FILE__)

require 'acts_as_ferret'

#config.action_controller.session_store = :active_record_store

# Initialize the Rails application.
Rails.application.initialize!

DB_STRING_MAX_LENGTH = 255
DB_TEXT_MAX_LENGTH = 40000
HTML_TEXT_FIELD_SIZE = 15

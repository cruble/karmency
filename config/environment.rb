# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Configure mailer
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :domain         => 'heroku.com',
  :port           => 587,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :authentication => :plain,
  :enable_starttls_auto => true
}

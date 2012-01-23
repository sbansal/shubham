if Rails.env == "production"
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'trace.ly'
  }
else
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => "587",
    :domain               => "hautworks.com",
    :user_name            => "support@hautworks.com",
    :password             => 'twister15',
    :authentication       => "plain",
    :enable_starttls_auto => true
  }
end




ActionMailer::Base.delivery_method = :smtp
desc "This task is called by the Heroku scheduler add-on everyday at "
task :send_email_reminders => :environment do
    puts "Sending reminder emails ........ "
    User.send_reminder_emails
    puts "and we are done enqueing the reminder emails."
end
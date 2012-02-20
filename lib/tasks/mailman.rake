namespace :mailman do
  desc "Process the mail queue" 
  task :work => :environment do 

    if ENV["GMAIL_USERNAME"] && ENV["GMAIL_PASSWORD"]

      Mailman.config.logger = Logger.new("log/mailman.log")

      Mailman.config.pop3 = {
        :server   => 'pop.gmail.com',
        :port     => 995,
        :ssl      => true,
        :username => ENV["GMAIL_USERNAME"],
        :password => ENV["GMAIL_PASSWORD"]
      }

      Mailman::Application.run do
        default do
          begin
            Receipt.receive(message)
          rescue Exception => e
            Mailman.logger.error "Exception occurred while receiving message:\n#{message}"
            Mailman.logger.error [e, *e.backtrace].join("\n")
          end
        end
      end

    end

  end
end

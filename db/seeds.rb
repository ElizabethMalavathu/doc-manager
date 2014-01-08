require_relative 'seeds/document_loader'

DocumentLoader.run_new!
User.create(:email => "benwilson512@gmail.com", :password => "asdf12345", :password_confirmation => "asdf12345")
User.create(:email => "elizabeth.wilson212@gmail.com", :password => "asdf12345", :password_confirmation => "asdf12345")
User.create(:email => "AJMitchell@GCC.EDU", :password => "docformatter", :password_confirmation => "docformatter")

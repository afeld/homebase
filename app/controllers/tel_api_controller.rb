class TelApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  HELP_TEXT = "help\n@all messgages everyone\n@[unit] messages a particular unit\n"
  UNSUBSCRIBE_MESSAGE = "You have been unsubscribed. :("
  
  def receive_text
    message_body = params["Body"].to_s.strip
    from_number = params["From"].to_s
    
    user = User.find_or_create_by_mobile_number(from_number)

    ix =
      if user.unit
        case message_body.downcase
        when /^#?(unsub(scribe)?|quit|stop)\.?$/
          # unsubscribe
          user.destroy
          puts "user unsubscribed"
          Telapi::InboundXml.new
        when /^#help|(help$)/
          puts "help requested"
          Telapi::InboundXml.new do
            Sms(
              HELP_TEXT,
              from: TEL_NUMBER,
              to: from_number
            )
          end
        when /^#list|(list$)/
          # TODO list users in building
        when /^@all/
          puts "messaging all residents of #{user.building.address}"
          user.building.message_all(message_body, user)
        when /^@(?<unit_number>\S+)/
          # TODO DM unit in building
        else
          # TODO follow-up (all or DM)
        end

      else # no unit
        # incomplete registration
        result = Geocoder.search(text).first
        user.unit = Unit.create_from_result(result) if result
        
        if user.unit
          user.save!
          puts "user registered"
          Telapi::InboundXml.new do
            Sms(
              "Registered at ##{user.unit.number}, #{user.building.address}",
              from: TEL_NUMBER,
              to: from_number
            )
          end
        else
          puts "reg. failed"
          Telapi::InboundXml.new do
            Sms(
              "Please respond with your full address, including unit number.",
              from: TEL_NUMBER,
              to: from_number
            )
          end
        end
      end 

    render text: ix.response
  end
  
  def get_directory
    
  end
  
end

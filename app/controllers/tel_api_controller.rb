class TelApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  HELP_TEXT = "help\n@all messgages everyone\n@[unit] messages a particular unit\n"
  UNSUBSCRIBE_MESSAGE = "You have been unsubscribed. :("
  
  def receive_text
    message_body = params["Body"].to_s.strip
    from_number = params["From"]
    
    user = User.find_or_create_by_mobile_number(from_number)

    case message_body.downcase
    when /^#?(unsub(scribe)?|quit|stop)\.?$/
      # unsubscribe
      user.destroy
    when /^#help|(help$)/
      HELP_TEXT
    when /^#list|(list$)/
      # TODO list users in building
    when /^@all/
      # TODO msg. all in building
    when /^@(?<unit_number>\S+)/
      # TODO DM unit in building
    else
      # TODO follow-up (all or DM)
    end

    render text: Telapi::InboundXml.new.response
  end
  
  def get_directory
    
  end
  
end

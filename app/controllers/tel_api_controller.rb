class TelApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  HELP_TEXT = "help\n@all messgages everyone\n@[unit] messages a particular unit\n"
  UNSUBSCRIBE_MESSAGE = "You have been unsubscribed. :("
  
  def receive_text
    message_body = params["Body"].to_s.strip
    from_number = params["From"].to_s
    
    user = User.find_or_create_by_mobile_number(from_number)

    ix =
      case message_body.downcase
      when /^#?(unsub(scribe)?|quit|stop)\.?$/
        # unsubscribe
        user.destroy
        Telapi::InboundXml.new
      when /^#help|(help$)/
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
        # TODO msg. all in building
      when /^@(?<unit_number>\S+)/
        # TODO DM unit in building
      else
        # TODO follow-up (all or DM)
      end

    render text: ix.response
  end
  
  def get_directory
    
  end
  
end

class AlertsController < ApplicationController
  @@client = Twilio::REST::Client.new TWILIO_ACCT, TWILIO_AUTH
  def make_call  
    # make a new outgoing call
    alert = Alert.find(params[:alert_id])
    alert.make_call
    render :text => 'Success!'
  end
  
  # @end snippet

  # @start snippet
  # TwiML response that reads the reminder to the caller and presents a
  # short menu: 1. repeat the msg, 2. directions, 3. goodbye
  def reminder
    @alert = Alert.find(params[:alert_id])
    @post_to = 'http://careshareapp.herokuapp.com/alerts/' + @alert.id.to_s + '/directions'
    @name = @alert.period.pill.user.name
    render :action => "reminder.xml.builder", :layout => false 
  end
  # @end snippet

  # @start snippet
  # TwiML response that inspects the caller's menu choice:
  # - says good bye and hangs up if the caller pressed 3
  # - repeats the menu if caller pressed any other digit besides 2 or 3
  # - says the directions if they pressed 2 and redirect back to menu
  def directions
    @alert = Alert.find(params[:alert_id])
    if params['Digits'] == '1'
      #user took medicine
      @alert.update_attributes(:took => true)
      redirect_to :action => 'thankyou'
      return
    end

    if params['Digits'] == '2'
      #10 minute reminder
      @alert.update_attributes(:took => false)
      redirect_to :action => 'goodbye'
      return
    end
  end
  
  def goodbye
    render :action => "goodbye.xml.builder", :layout => false 
  end
  
  def thankyou
    render :action => "thankyou.xml.builder", :layout => false 
  end
end
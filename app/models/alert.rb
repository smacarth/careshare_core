class Alert < ActiveRecord::Base
  belongs_to :period
  
  def self.create_alert(p)
    alert = Alert.create(:period => p)
    alert.make_call
  end
  
  def make_call
    client = Twilio::REST::Client.new TWILIO_ACCT, TWILIO_AUTH
    call = client.account.calls.create(
      :from => '+12014720636',
      :to => '+1' + period.pill.user.phone,
      :url => 'http://careshareapp.herokuapp.com/alerts/' + id.to_s + '/reminder',
    )
  end
end

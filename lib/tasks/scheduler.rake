desc "This task is called by the Heroku scheduler add-on"
task :snooze => :environment do
  Period.all.each do |p|
    if ((p.time_of_day.hour * 100) + p.time_of_day.min) < ((Time.now.hour * 100) + Time.now.min) #time passed
      alerts = p.alerts.order('created_at desc')
      
      if !alerts #first pill
        Alert.create_alert(p)
      else
        alerts.where('took = false').each { |a| a.make_call } #call snoozed alerts
        
        case p.pill.frequency.name #up to date on meds
        when 'daily'
          Alert.create_alert(p) unless Alert.where('took = false AND period_id = ?', p.id).count > 0  
        when 'every other day' 
          Alert.create_alert(p) if !alerts.last.took
        when 'weekly'
          Alert.create_alert(p) if alerts.last.created_at < Time.now - 7.days
        when 'monthly'
          Alert.create_alert(p) if alerts.last.month < Time.now.month
        end
      end
    end
  end
end
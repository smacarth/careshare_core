class PillsController < ApplicationController
 
  def find
    pills = PillData.search_pills(params[:query])
    render text: "func(" + pills.to_json[1..pills.to_json.length - 2] + ")"
  end
  
  def create_pill
    user = User.first
    pill_data = PillData.find(params[:pill_data_id][1..params[:pill_data_id].length-1])
    pill = Pill.create(:user => user, :pill_data => pill_data)
    render text: "func({pill_id: " + pill.id.to_s + "})"
  end
  
  def update_pills
    pill = Pill.find(params[:pill_id])
    unit = Unit.find_or_create_by_name(params[:unit])
    pill.update_attributes(:dosage_amount => params[:dosage],
                           :location => params[:location], :unit => unit)
    
    Frequency.create(:pill => pill, :name => params[:frequency], :number => params[:number])
    render text: "func({pill_id: " + pill.id.to_s + "})"
  end
  
  def show
    pill = Pill.find(params[:id])
    render text: "func(" + pill.to_json(:include => [:frequency, :periods])[1..pill.to_json.length - 2] + ")"
  end
  
  def reminders
    periods = Period.all
    j = ''
    periods.each do |p|
      hour = '%02i' % p.time_of_day.hour
      min = '%02i' % p.time_of_day.min
      j+= "{\"freq\": \"#{p.pill.frequency.name}\", \"location\": \"#{p.pill.location}\", \"name\": \"#{p.pill.pill_data.name}\", \"dosage\": #{p.pill.dosage_amount}, \"unit\": \"#{p.pill.unit.name}\", \"date\": \"#{hour}:#{min}\"},"
    end
    j = j[0..j.length-2]
    render text: "func([" + j + "])"
  end
  
  def refills
    render text: "func({})"
  end
  
  def show_periods
    periods = Pill.find(params[:pill_id]).frequency.number
    render text: "func({number: " + periods.to_s + "})"
  end

  def add_periods
    pill = Pill.find(params[:pill_id])
    pill.user.update_attributes(:phone => params[:phone])
 
    count = 1
    pill.frequency.number.times do
      Period.create(:pill => pill, :time_of_day => params[('period' + count.to_s).to_sym])
      count = count + 1
    end
    render :text => "func({})"
  end
end
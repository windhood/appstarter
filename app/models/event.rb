class Event < ActiveRecord::Base
  def start_datetime 
    return "#{start_date}" if start_time.blank?
    return "#{start_date} #{start_time}" 
  end
  
  def end_datetime 
    return "#{end_date}" if end_time.blank?
    return "#{end_date} #{end_time}" 
  end
  
  def self.generate_test_data
    events = []
    (1..5).each  do |n|
      event = Event.new(:name =>"event #{n}", :number => "N#{n}")
      event.id = n
      event.start_date = Time.now.localtime.strftime("%Y-%m-%d")
      event.start_time = "0:0:0"
      event.end_date = event.start_date
      event.end_time ="23:59:59"
      event.description = "blahbalh"
      event.source = "Coquitlam"
      event.signup_url = "http://google.com"
      events << event
    end
    events
  end
  
  def self.find_test_data(id)
    event = Event.new(:name =>"event #{id}", :number => "N#{id}")
    event.id = id
    event.start_date = Time.now.localtime.strftime("%Y-%m-%d")
    event.start_time = "0:0:0"
    event.end_date = event.start_date
    event.end_time ="23:59:59"
    event.description = "blahbalh"
    event.source = "Coquitlam"
    event.signup_url = "http://google.com"
    event
  end
end
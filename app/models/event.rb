class Event < ActiveRecord::Base
  belongs_to :application

  include Filterable
	
  #if !push_start_time.empty? { push_start_time =  (push_start_time / 1000) }

  scope :app_name, -> boo { where app_name: boo }
  scope :user_id, -> (user_id) { where user_id: user_id }
  scope :user_type, -> (user_type) { where user_type: user_type }
  scope :tenant, -> (tenant) { where tenant: tenant }
  scope :url, -> (url) { where("url like ?", "%#{url}%" ) }
  scope :domain, -> (domain) { where("domain like ?", "%#{domain}%" ) }
  scope :search_words, -> (search_words) { where("search_words like ?", "%#{search_words}%" ) }
  scope :push_start_time, -> (push_start_time) { where( "start_time_stamp >= ?",  Time.at(push_start_time.to_i) ) }
  scope :push_end_time, -> (push_end_time) { where("end_time_stamp <= ?",  Time.at(push_end_time.to_i ) ) }
  scope :duration, -> (duration) { where format_duration(duration)  }
 

  def domains  
    @domains ||= Event.select( :domain ).uniq.order(:domain)
  end
  

private

  def self.format_duration(data)
   sign, time = data.split
   startSQL = " duration " + sign + " " + "(" + time + "::text||'secs')::interval"
   #startSQL + " " + sign + " " + time.to_s
   #return "duration " + sign + " " + Time.at(time.to_i).gmtime.strftime('%R:%S').to_s
   #return  startSQL + sign + " " + Time.at(time.to_i).gmtime.to_s
  end

end

module EventsHelper

  def build_app_hash(productivity)
    
    @bus_hash = {}
    @non_bus_hash = {}
    @total_time = {}
    @prod_time = 0
    @non_prod_time = 0

    @url_hash = {}
 
    browsers = ["Safari", "Flash Player (Safari Internet plug-in)", "QuickTime Plugin (Safari Internet plug-in)", "Firefox", "Firefox Plugin Content (Shockwave Flash)", "Firefox Plugin Content (Silverlight Plug-In)", "Google Chrome" ]


    @events.each do |event|

      if !productivity
        if @bus_hash.has_key?(event.app_name.to_sym)
          @bus_hash[event.app_name.to_sym] = @bus_hash[event.app_name.to_sym] + ( event.end_time_stamp - event.start_time_stamp)
        else
          @bus_hash[event.app_name.to_sym] = (event.end_time_stamp - event.start_time_stamp) 
          insert_app_name(event.app_name)
        end
        
      else  # productivity is True
        if browsers.include?(event.app_name)
          is_business_relevant?( event, browsers)
          
        elsif @bus_hash.has_key?(event.app_name.to_sym)
          @bus_hash[event.app_name.to_sym] = @bus_hash[event.app_name.to_sym] + ( event.end_time_stamp - event.start_time_stamp)

        elsif @non_bus_hash.has_key?(event.app_name.to_sym)
          @non_bus_hash[event.app_name.to_sym] = @non_bus_hash[event.app_name.to_sym] + ( event.end_time_stamp - event.start_time_stamp)

        elsif is_business_relevant?( event, browsers)
          @bus_hash[event.app_name.to_sym] = (event.end_time_stamp - event.start_time_stamp)
        
	else 
          @non_bus_hash[event.app_name.to_sym] = (event.end_time_stamp - event.start_time_stamp)
          insert_app_name(event.app_name)  

	end # end !bus_has.has_key?

      end# end else productivity is True

    
    end # end each/do
  
  @bus_hash.each do |key, value|
      @prod_time = @prod_time + value
  end


  @non_bus_hash.each do |key, value|
      @non_prod_time = @non_prod_time + value
  end

  @prod_time.round()
  @non_prod_time.round()
  @total_time = @prod_time + @non_prod_time


  end# build_app_hash

  ######
  def insert_app_name(passed_name)
 
    if !AppName.where(:app_name => passed_name).first
      newRecord = AppName.create(:app_name => passed_name, :business_relevant => 99)
    end
  end

  ######
  def is_business_relevant?(event, browsers)
 
    int = 0
    record = AppName.where(:app_name => event.app_name).first
    if record.nil? || record.business_relevant == 0
      @non_bus_hash[event.app_name.to_sym] = (event.end_time_stamp - event.start_time_stamp)
      return false
    elsif record.business_relevant == 1
      return true
    elsif record.business_relevant == 2
      records = Url.where("domain LIKE ? AND business_relevant = 1", "%#{ event.domain}%")
      if records.empty?
        if event.search_words != ""
          records = Url.where("keyword LIKE ?", "%#{ event.search_words}%")
        end
      end
      if records.empty?
        @non_bus_hash[event.app_name.to_sym] = (@non_bus_hash[event.app_name.to_sym] ||= 0 ) + (event.end_time_stamp - event.start_time_stamp)
        return false
      else 
        @bus_hash[event.app_name.to_sym] = (@bus_hash[event.app_name.to_sym] ||= 0 ) + (event.end_time_stamp - event.start_time_stamp)
        return true
      end
    end
    
  end


  ######
  def get_business_urls()
   
    @non_bus_url_hash = {}
    @bus_url_hash = {}

    array_domains = []
    records = Url.where(:business_relevant => 1)
    records.each do |record|
      array_domains.push(record)
    end
    records
  end

  #####
  def sort_urls(records)

    bus_domains = records.map(&:domain)
    bus_keywords = records.map(&:keyword)
    


    browsers = ["Safari", "Flash Player (Safari Internet plug-in)", "QuickTime Plugin (Safari Internet plug-in)", "Firefox", "Firefox Plugin Content (Shockwave Flash)", "Firefox Plugin Content (Silverlight Plug-In)", "Google Chrome" ]
    
    @events.each do |event|
      
      url_record_name = event.app_name + "-" + event.domain + "  query=" + event.search_words
      domain_string = event.domain

      if browsers.include?(event.app_name)

	if bus_domains.any? {|s| s.match /#{domain_string}/ }
	  @bus_url_hash[url_record_name.to_sym] = (@bus_url_hash[url_record_name.to_sym] ||= 0 ) + (event.end_time_stamp - event.start_time_stamp)
        #### This keyword feature does not work ####
        #elsif ( event.search_words != "" && bus_keywords.any? {|s| s.match("/{#event.search_words}")} )
        #  @bus_url_hash[url_record_name.to_sym] = (@bus_url_hash[url_record_name.to_sym] ||= 0 ) + (event.end_time_stamp - event.start_time_stamp)
        #  puts "Productive Keywords!!"
        ###
	else
	  @non_bus_url_hash[url_record_name.to_sym] = (@non_bus_url_hash[url_record_name.to_sym] ||= 0 ) + (event.end_time_stamp - event.start_time_stamp)
	end
      end # end browsers.include?

    end # @events.each

  end # end def


  #####
  def group_records()
    @grouped = @events.group_by_day(:start_time_stamp).sum(:duration) 
    

  end


end

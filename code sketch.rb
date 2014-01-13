class TimeContext
  def current_time
  end

  def get_value(attribute_name, currency_symbol, time_offset)

  end
end

class RealtimeContext < TimeContext
  def current_time
		Time.now
  end	
  def get_value(attribute_name, currency_symbol, time_offset)

  end
end

class SimulatedContext < TimeContext
  def current_time
		#this date is assigned by the runner.
  end
	
  def get_value(attribute_name, currency_symbol, time_offset)

  end
end

class Runner
  def self.start(config_path)
    runner = self.new(config_path)
    runner.start
  end
  
  def initialize(config_path)
    @config = parse_config(config_path)
  end
  
  def start
  end 
  
  def parse_config(config_path)
    options = JSON.parse(config_path)
    options = options.symbolize_keys 
  end
end

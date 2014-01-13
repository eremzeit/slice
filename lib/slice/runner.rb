# The Runner class is the main entry point into running an automated trader.
# It's input is a configuration file.  It's side effect is that trades are made,
# or in the case of a SimulatedRunInstance, it will simulate the trades.  Always
# it will record the output in it's own individual directory.
  
    
class Runner
  # Pass the path to a cofiguration file that 
  # contains the parameters to the run.
  def self.start(config_path)
    runner = self.new(config_path)
    runner.start
  end
  
  def initialize(config_path)
    @config = parse_config(config_path)
  end
  
  def start
    run_instance.each_iteration do |start|
          
    end
  end 
  
  def parse_config(config_path)
    options = JSON.parse(config_path)
    options.symbolize_keys 
  end

  def run_instance
    @run_instance ||= @config[:run_instance].constantize.new(@config)
  end

  def strategy
    @run_instance ||= @config[:strategy].constantize.new(@config)
  end
  
  #TODO: should this actually be something that the runner does?
  def time_context
    options = @config[:time_context]
    context_class = options[:type].constantize
    context_class.new(options)
  end

  def strategy(time_context)

  end
end



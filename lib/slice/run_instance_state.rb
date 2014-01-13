


class RunInstanceState
  # Directory Structure
  # ./run_instances
  #   ./1580258
  #     log.txt
  #     config.json
  #     state.json      
  #
  def initialize(id, config)
    @id = id
    @config = config
    Dir.make_dir(base_dir)
    write_config(config)
  end

  def base_dir
    "./run_instances/#{id.to_s}"
  end
  
  # Writes the configuration of the instance to disk.  This should
  # only be called once.
  def write_config
    config_file = File.open(config_path, 'w')
    config_file.write(@config.to_json)
    config_file.close
  end

  def state
    if @state.nil?
      state_file = File.open(state_path, 'r')
      @state = JSON.parse(state_file.read)
      state_file.close
    end

    @state
  end

  def start
    @config. 
  end

  def finish

  end

  def started?
    
  end

  def finished?

  end
  
  # @return the path of the log file to use
  def log_path
    "#{base_path}/log.txt"
  end
  
  def config_path
    "#{base_path}/config.json"
  end
  
  def state_path
    "#{base_path}/state.json"
  end

  def flush

  end

  def log(str)
    #append mode
    @log_file ||= File.open(log_path, 'a')
    
    str = "[#{Time.now}] #{str}"
    @log_file.writeline(str) 
  end

  def finish
    flush

    log_file.close rescue nil
  end
end

class RunInstance
  def initialize(options)
    @options = options
    @state = RunInstanceState.new(id)
  end

  def id
    @id ||= Time.now.to_i
  end

  def each_iteration
    raise NotImplementedException.new
  end
  
  def on_start
    raise NotImplementedException.new
  end

  def on_complete
    raise NotImplementedException.new
  end
  
##TODO: should this actually be something that the run instance does?
#  def time_context
#    options = @config[:time_context]
#    context_class = options[:type].constantize
#    context_class.new(options)
#  end
end

class SimulatedRunInstance < RunInstance
  def each_iteration
    on_start

    TimeWindower.window(options[:start_time], options[:end_time]).each do |start|
      yield(start)
      @state.flush
    end
    
    on_complete
  end

  def time_context
    @time_context ||= SimulatedTimeContext.new
  end
end

# Note: in the current implementation, each iteration only occurs at a 
# point in time, as opposed to having a start date and end date.
class RealtimeRunInstance < RunInstance
  def each_iteration
    if !@state.started?
      @state.start
      on_start
    end

    if !@state.finished?
      if current_time < options[:end_time]
        yield(current_time)
      else
        @state.finish
        on_complete
      end
    end
    
    @state.close
  end

  def current_time
    Time.now
  end

  def time_context
    @time_context ||= SimulatedTimeContext.new
  end
end



#{
#  'run_instance': {
#    'type': 'SimulatedRunInstance',
#    #'type': 'RealtimeRunInstance',
#    'start_date', '',
#    'end_date', ''
#  },
#
#  portfolio: {
#
#  },
#
#
#  'strategy': {
#
#
#  }
#}

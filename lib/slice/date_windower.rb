class DateWindower
  def self.windows(start_time, end_time, interval_seconds)
    diff = end_time - start_time
    
    current_time = start_time
    
    while current_time <= end_time
      next_time = [current_time + current_time, end_time].min
      
      yield(current_time, next_time)
    end
  end
end

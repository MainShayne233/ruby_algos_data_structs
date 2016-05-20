class Array
  def sorted?
    self == self.sort
  end

  def swap!(index1, index2)
    tmp = self[index1]
    self[index1] = self[index2]
    self[index2] = tmp
  end

  def end
    self.length - 1
  end
end

class Sort

  def self.bubble_sort(list)
    passes = 0
    until passes == list.end
      (0..list.length - passes - 2).each do |index|
        list.swap!(index, index + 1) if list[index] > list[index + 1]
      end
      passes += 1
    end
    list
  end

  def self.select_sort(list)
    (0..list.count - 1).each do |start_index|
      min_swap = list[start_index]
      min_swap_index = start_index
      (start_index..list.end).each do |index|
        if list[index] < min_swap
          min_swap = list[index]
          min_swap_index = index
        end
      end
      list.swap!(start_index, min_swap_index) unless start_index == min_swap_index
    end
    list
  end

end


def random_list(length: 100, min: 0, max: 1000)
  (0..length).map{rand(max-min) + min}
end


def benchmark(sorting_methods)
  times = {}
  sorting_methods.each {|method| times[method] = []}
  100.times do
    list = random_list
    sorting_methods.each do |method|
      start = Time.now
      Sort.send("#{method}", Array.new(list))
      times[method] << Time.now - start
    end
  end
  times.each {|method, time| times[method] = times[method].reduce(:+) / 100}
  times.each do |method, time|
    puts "#{method}: #{time}"
  end
end

benchmark ['bubble_sort', 'select_sort']
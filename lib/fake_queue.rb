class FakeQueue
  attr_reader :data

  def initialize(first_data = nil)
    @data = [first_data].compact
  end

  def add(value)
    @data << value
  end

  def remove
    return nil if @data.empty?

    removed_value = @data[0]
    @data = @data[1..]

    removed_value
  end

  def empty?
    @data.empty?
  end

  def size
    @data.size
  end
end

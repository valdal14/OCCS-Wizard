class Wizard

  attr_accessor :extension_id, :developer_id, :created_at, :extension_name

  def set_extension_id(ext)
    raise ArgumentError, 'Argument is not a String' unless ext.size == 36 && ext.is_a?(String)
    self.extension_id = ext
  end

  def get_extension_id
    self.extension_id
  end

  def set_developer_id(dev_id)
    raise ArgumentError, 'Developer ID value cannot be empty' unless dev_id.size != 0
    string_length = dev_id.size
    dev_id_number = dev_id.to_s
    value = nil

    if string_length == dev_id_number.size
      value = dev_id.to_i
    end

    if value.class == Fixnum
      self.developer_id = value
    end
  end

  def get_developer_id
    self.developer_id
  end

  def set_created_at
    time = Time.now
    current = time.to_s.scan(/\w+/)
    today = "#{current[0]}-#{current[1]}-#{current[2]}"
    self.created_at = today
  end

  def get_created_at
    self.created_at
  end

  def set_extension_name(ext_name)
    raise ArgumentError, 'Extension name cannot be empty' unless ext_name.size > 0
    name = ext_name.delete(' ').downcase
    self.extension_name = name
  end

  def get_extension_name
    self.extension_name
  end

end

w = Wizard.new
w.set_extension_id("123456789012345678901234567890123456")
puts w.get_extension_id
w.set_developer_id("12345678")
puts w.get_developer_id
require 'fileutils'
require 'json'

class Wizard

  attr_accessor :extension_id, :developer_id, :created_by, :created_at, :extension_name, :description
  VERSION = 1

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

  def set_created_by(name = "OCCS Wizard Developer")
    self.created_by = name
  end

  def get_created_by
    self.created_by
  end

  def set_extension_name(ext_name)
    raise ArgumentError, 'Extension name cannot be empty' unless ext_name.size > 0
    self.extension_name = ext_name
  end

  def get_extension_name
    ext_name = self.extension_name.delete(' ').downcase
  end

  def set_description(desc)
    raise ArgumentError, 'Extension description cannot be empty' unless desc.size > 0
    self.description = desc
  end

  def get_description
    self.description
  end

  # crate the ext.json file
  def create_ext_json_file(directory)
    ext_json = {
        extensionID: self.get_extension_id,
        developerID: self.get_developer_id,
        createdBy: self.created_by,
        name: self.get_extension_name,
        version: VERSION,
        timeCreated: self.get_created_at,
        description: self.get_description
    }
    # write the file
    File.open(directory,"w") do |f|
      f.write(ext_json.to_json)
    end

  end

  # Project Structure
  def create_project_root_folder
    Dir.chdir('..')
    raise Exception, "Folder #{self.extension_name} already exists" unless !File.directory?("#{self.extension_name}")
    # make a new root dir with the extension name
    FileUtils.mkdir(self.extension_name)
    # enter inside the new root dirt
    Dir.chdir("#{self.extension_name}")
    # create the widget folder
    FileUtils.mkdir('widget')
    # create the file ext.json
    self.create_ext_json_file("ext.json")
    # enter inside widget folder
    Dir.chdir('./widget')
    # create the extension name folder with no spaces and lowered
    FileUtils.mkdir(self.get_extension_name)
  end


end

w = Wizard.new
w.set_extension_id("123456789012345678901234567890123456")
puts w.get_extension_id
w.set_developer_id("12345678")
puts w.get_developer_id
w.set_extension_name "OCCS Extension"
puts w.get_extension_name
w.set_created_by
w.get_created_by
w.set_created_at
w.get_created_at
w.set_description("New OCCS Extension")
w.get_description
w.create_project_root_folder
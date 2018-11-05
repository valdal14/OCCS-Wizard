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
      # call the convert_to_json private method and write a json file
      f.write(convert_to_json(ext_json))
    end
  end

  # create the file widget.json
  def create_widget_json_file(directory)
    widget_json = {
        name: self.get_extension_name,
        version: VERSION,
        global: false,
        javascript: "widget-#{self.get_extension_name}-js",
        pageTypes: ["home"],
        imports: ["products"],
        jsEditable: true,
        config: {}
    }

    # write the file
    File.open(directory,"w") do |f|
      # call the convert_to_json private method and write a json file
      f.write(convert_to_json(widget_json))
    end
  end

  # create the display.template file
  def create_display_template_file(directory)
    html = %{<!-- Template File -->\n
<div class="myWidget">Hello World</div>}

    File.open(directory, "w") do |f|
      f.write(html)
    end
  end

  # create the less file
  def create_less_file(directory)
    less = %{/* Widget CSS Less */\n
.myWidget {}}

    File.open(directory, "w") do |f|
      f.write(less)
    end
  end

  # create the javascript file
  def create_js_file(directory)
    js = %{// Javascript widget file\n
    define(\n
      // Dependencies\n
      ['jquery', 'knockout'],\n
      // Module Implementation\n
      function(ko) {\n
         // We recommend enabling strict checking mode\n
         'use strict';\n
         // Private variables and functions can be defined here...\n
         var SOME_CONSTANT = 1024;\n
         var privateMethod = function () {\n
           // ...\n
         };\n
         return {\n
          // Widget JS\n
          // Some member variables...\n
          // Some public methods...\n
        }\n
    });}

    File.open(directory, "w") do |f|
      f.write(js)
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
    # enter inside the extensionname folder
    Dir.chdir("./#{self.get_extension_name }")
    # make the template folder
    FileUtils.mkdir("templates")
    # make the js folder
    FileUtils.mkdir("js")
    # make the less folder
    FileUtils.mkdir("less")
    # write the widget.json file
    self.create_widget_json_file("widget.json")
    # move into the templates folder
    Dir.chdir("./templates")
    # write the display.template file
    self.create_display_template_file("display.template")
    # move back one dir
    Dir.chdir("..")
    # move inside the less folder
    Dir.chdir("./less")
    # write the less file
    self.create_less_file("widget.less")
    # move back one dir
    Dir.chdir("..")
    # move inside the js folder
    Dir.chdir("./js")
    # write the js file
    self.create_js_file("widget-#{self.get_extension_name}-js.js")
    # move back one dir
    Dir.chdir("..")
    # create the config folder
    Dir.mkdir("config")

  end

  private
  def convert_to_json(string)
    json = string.to_json
    json_formatted = JSON.parse(json)
    JSON.pretty_generate(json_formatted)
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
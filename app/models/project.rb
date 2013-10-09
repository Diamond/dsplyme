class Project < ActiveRecord::Base
  before_create :upload
  attr_accessor :file_data
  #validate :identifier, presence: true, uniqueness: true
  #validate :title, presence: true, uniqueness: true 

  def data_path
    Rails.root.join('public', 'data', self.path)
  end

  def get_html
    content = ''
    File.open(self.path, "r") { |f| content = f.read }
    return content
  end

  private
  def upload
    path = Rails.root.join('public', 'data', self.file_data.original_filename)
    file_data = self.file_data.read
    File.open(path, 'wb+') do |f|
      f.write(file_data)
    end

    directory = path.to_s.gsub('.zip', '')

    FileUtils::mkdir_p(directory)
    
    unzip_file(path, directory)
    self.identifier = Digest::MD5.hexdigest(file_data)
  end

  def unzip_file (file, destination)
    Zip::ZipFile.open(file) do |zip_file|
      zip_file.each do |f|
        if f.name.include?('.unity3d')
          project_name = self.file_data.original_filename.gsub('.zip', '')
          self.path = "/data/#{project_name}/#{f.name}"
          f_path = File.join(destination, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        end
      end
    end
  end
end

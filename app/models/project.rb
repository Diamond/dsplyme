class Project < ActiveRecord::Base
  before_create :upload
  attr_accessor :file_data
  validate :identifier, presence: true, uniqueness: true
  validate :title, presence: true, uniqueness: true 
  belongs_to :user

  def data_path
    Rails.root.join('public', 'data', self.path)
  end

  private
  def upload
    self.identifier = Digest::MD5.hexdigest(self.title + Time.now.to_s)
    pieces = self.file_data.original_filename.split('.')
    if pieces.last.downcase == 'zip'
      handle_zip_file
    elsif pieces.last.downcase == 'unity3d'
      handle_unity3d_file
    else
      raise Exception.new("Invalid file type uploaded!")
    end
  end

  def handle_unity3d_file
    FileUtils.mkdir_p(Rails.root.join('public', 'data', self.identifier))
    path = Rails.root.join('public', 'data', self.identifier, self.file_data.original_filename)
    File.open(path, 'wb+') do |f|
      f.write(self.file_data.read)
    end
    self.path = "/data/#{self.identifier}/#{self.file_data.original_filename}" 
  end

  def handle_zip_file
    path = Rails.root.join('public', 'data', self.file_data.original_filename)
    file_data = self.file_data.read
    File.open(path, 'wb+') do |f|
      f.write(file_data)
    end

    directory = path.to_s.gsub('.zip', '')

    FileUtils::mkdir_p(directory)
    
    unzip_file(path, directory)
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

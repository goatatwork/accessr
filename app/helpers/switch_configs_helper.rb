module SwitchConfigsHelper
  def path_to_file_on_disk
    ActiveStorage::Blob.service.path_for(self.file.key) if self.file.attached?
  end

  def contents_of_file_on_disk
    file = File.open(self.path_to_file_on_disk)
    file_data = file.readlines.map(&:chomp)
    file.close
    file_data
  end
end

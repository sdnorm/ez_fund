module Storable
  extend ActiveSupport::Concern

  def storage_folder(custom_folder = nil)
    if custom_folder.present?
      custom_folder
    else
      case self.class.name
      when "User"
        "users"
      when "Import"
        "imports"
      else
        "misc"
      end
    end
  end

  def storage_path(filename, custom_folder = nil)
    "#{storage_folder(custom_folder)}/#{id}/#{filename}"
  end
end

class ImageUploader < Shrine
  plugin :activerecord
  plugin :logging, logger: Rails.logger
end

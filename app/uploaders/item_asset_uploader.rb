# encoding: utf-8

class ItemAssetUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :small do
      process :resize_to_limit => [45,45]
    end
    version :medium do
      process :resize_to_limit => [145,145]
    end
    version :home do
      process :resize_to_limit => [199, 161]
    end
    version :home_big do 
      process :resize_to_limit => [267,210]
    end
    version :large do
      process :resize_to_limit => [312,281]
    end
    
    def extension_white_list
         %w(jpg jpeg gif png)
       end
  
      def cache_dir
       "#{Rails.root}/tmp/uploads"
      end

      def default_url
        ("/assets/fallback/" + [version_name, "no_image.png"].compact.join('_'))
      end
end

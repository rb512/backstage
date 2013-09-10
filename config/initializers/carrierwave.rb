CarrierWave.configure do |config|

    config.root = Rails.root.join('tmp')
    config.cache_dir = 'carrierwave'
    config.fog_credentials = {
        :provider => 'AWS',
        :aws_access_key_id => 'AKIAJCHUCA6I7LZEDLNQ',
        :aws_secret_access_key => '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'
    }
    config.fog_directory = 'grubshire'

end
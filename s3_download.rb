# frozen_string_literal: true

# ruby s3_download.rb my-bucket image.png fotos/image.png

require_relative 's3_config'

class S3Downloader
  def self.download_file(bucket_name, object_key, local_path)
    response = S3Config.client.get_object(
      bucket: bucket_name,
      key: object_key
    )

    File.binwrite(local_path, response.body.read)

    puts "Arquivo #{object_key} baixado para #{local_path}"
  rescue Aws::S3::Errors::NoSuchKey => e
    puts "Arquivo não encontrado: #{e.message}"
  rescue StandardError => e
    puts "Erro no download: #{e.message}"
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length != 3
    puts 'Uso: ruby s3_download.rb <bucket_name> <object_key> <local_path>'
    exit 1
  end
  S3Downloader.download_file(ARGV[0], ARGV[1], ARGV[2])
end

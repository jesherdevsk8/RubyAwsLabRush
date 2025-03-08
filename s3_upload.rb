# frozen_string_literal: true

# ruby s3_upload.rb my-bucket path/file.txt file_to-s3.txt

require_relative 's3_config'

class S3Uploader
  def self.upload_file(bucket_name, file_path, object_key)
    file_content = File.read(file_path)
    S3Config.client.put_object(
      bucket: bucket_name,
      key: object_key,
      body: file_content
    )
    puts "Arquivo #{object_key} enviado com sucesso para o bucket #{bucket_name}"
  rescue Aws::S3::Errors::NoSuchBucket => e
    puts "Bucket não encontrado: #{e.message}"
  rescue StandardError => e
    puts "Erro no upload: #{e.message}"
  end
end

# Execução via linha de comando
if __FILE__ == $0
  if ARGV.length != 3
    puts 'Uso: ruby s3_upload.rb <bucket_name> <file_path> <object_key>'
    exit 1
  end
  S3Uploader.upload_file(ARGV[0], ARGV[1], ARGV[2])
end

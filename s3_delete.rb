# frozen_string_literal: true

# ruby s3_delete.rb my-bucket file_on_s3.txt

require_relative 's3_config'

class S3Deleter
  def self.delete_file(bucket_name, object_key)
    S3Config.client.delete_object(
      bucket: bucket_name,
      key: object_key
    )
    puts "Arquivo #{object_key} excluído do bucket #{bucket_name}"
  rescue Aws::S3::Errors::NoSuchKey => e
    puts "Arquivo não encontrado: #{e.message}"
  rescue StandardError => e
    puts "Erro na exclusão: #{e.message}"
  end
end

# Execução via linha de comando
if __FILE__ == $0
  if ARGV.length != 2
    puts 'Uso: ruby s3_delete.rb <bucket_name> <object_key>'
    exit 1
  end
  S3Deleter.delete_file(ARGV[0], ARGV[1])
end

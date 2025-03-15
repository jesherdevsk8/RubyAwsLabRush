# frozen_string_literal: true

# ruby s3_list.rb my-bucket

require_relative 's3_config'

class S3Lister
  def self.list_files(bucket_name)
    response = S3Config.client.list_objects_v2(
      bucket: bucket_name
    )

    if response.contents.empty?
      puts "O bucket #{bucket_name} está vazio."
    else
      puts "Arquivos no bucket #{bucket_name}:"
      response.contents.each do |object|
        puts " - #{object.key}"
      end
    end
  rescue Aws::S3::Errors::NoSuchBucket => e
    puts "Bucket não encontrado: #{e.message}"
  rescue StandardError => e
    puts "Erro ao listar os arquivos: #{e.message}"
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.length != 1
    puts 'Uso: ruby s3_list.rb <bucket_name>'
    exit 1
  end
  S3Lister.list_files(ARGV[0])
end

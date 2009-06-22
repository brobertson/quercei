require "rubygems"
require "fastercsv"


task :load_words => :environment do
 puts "Loading!"
 ActiveRecord::Base.connection.execute(load_data_infile("/tmp/words.csv"))
end

private
def load_data_infile(temp_path)
           <<-EOF
                 LOAD DATA INFILE "#{temp_path}" REPLACE
                          INTO TABLE words 
                          CHARACTER SET UTF8
                          FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
                             (perseusId, number, form, sentence, document_urn, span, subdoc, lang_id)
                            SET created_at = '#{Time.current.to_s(:db)}',
                            updated_at = '#{Time.current.to_s(:db)}';
            EOF
        end

task :load_subdocs => :environment do
   puts "Loading subdocs!"
    ActiveRecord::Base.connection.execute(load_subdoc_data_infile("/tmp/subdocs.csv"))
end

private
def load_subdoc_data_infile(temp_path)
           <<-EOF
                 LOAD DATA INFILE "#{temp_path}" REPLACE
                          INTO TABLE subdocs
                          CHARACTER SET UTF8
                          FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
                             (document_urn, label, field1, value1, field2, value2)
                            SET created_at = '#{Time.current.to_s(:db)}',
                            updated_at = '#{Time.current.to_s(:db)}';
            EOF
        end

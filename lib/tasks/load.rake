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


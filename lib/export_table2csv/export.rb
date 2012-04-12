module ExportTable2csv
  require 'rubygems'
  require 'active_support'
  require 'active_record'
  require 'logger'
  require 'csv'

  class Export
    CHUNK_SIZE = 5000
    def initialize(opts={
                     :active_record_config => {},
                     :model => nil,
                     :fields => [],
                     :csv_format => {},
                     :order => '',
                     :conditions => {}
      })
      csv_default_format = {
        :write_headers => true,
        :quote_char => %Q~'~,
        :row_sep => "\n",
        :col_sep => ",",
        :force_quotes => 'true'
      }
      @model = opts[:model]
      @fields = opts[:fields]
      @csv_format = csv_default_format.merge((opts[:csv_format]||{}))
      @conditions = opts[:conditions]
      @order = opts[:order]
      unless defined?(Rails)
        @db_config = opts[:active_record_config]
        ActiveRecord::Base.logger = Logger.new(STDOUT)
        ActiveRecord::Base.establish_connection(@db_config)
      end
    end

    def export_lines
      read_rows do |rows|
        rows.each{|row| yield CSV.generate_line(@fields.map{|f| row.try(f)},@csv_format)  }
      end
    end

    def export_to_csv(output_file_path)
      File.open(output_file_path,"w") do |file|
        file.write(CSV.generate_line(@fields.map{|f| f},@csv_format))
        export_lines{|row| file.write row}
      end
    end

    private
    def read_rows
      row_count = @model.where(@conditions).count
      1.upto(row_count.div(CHUNK_SIZE) + 1) do |i|
        offset = (i-1)*CHUNK_SIZE
        yield @model.select(@fields.join(',')).where(@conditions).offset(offset).limit(CHUNK_SIZE).order(@order)
      end
    end

  end
end

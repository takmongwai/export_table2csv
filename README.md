# ExportTable2csv

using ActiveRecord export data to csv file.
Separation Of Large data

## Installation

Add this line to your application's Gemfile:

    gem 'export_table2csv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install export_table2csv

## Usage

    active_record_config = {
      :adapter  => "postgresql",
      :encoding => "unicode",
      :host     => "127.0.0.1",
      :username => "pgsql",
      :password => "none",
      :database => "test"
    }
    class User < ActiveRecord::Base;end
    export = ExportTable2csv::Export.new(
      :active_record_config => active_record_config,
      :model => User,
      :fields => [:id,:user_id,:user_mobile,:tx_code],
      :conditions => ["id > ?",'100'],
      :order => 'id desc'
    )
    export.export_lines{|csv_row| p csv_row}
    or
    export.export_to_csv("/tmp/1111.csv")


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

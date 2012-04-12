# -*- encoding : utf-8 -*-

require 'pg'
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')



describe "export test" do
  before(:all){
    active_record_config = {
      :adapter  => "postgresql",
      :encoding => "unicode",
      :host     => "127.0.0.1",
      :username => "pgsql",
      :password => "none",
      :database => "test"
    }
    class User < ActiveRecord::Base;end
    @export = ExportTable2csv::Export.new(
      :active_record_config => active_record_config,
      :model => GatewayRecord,
      :fields => [:id,:user_id,:user_mobile,:tx_code],
      :conditions => ["id > ?",'100'],
      :order => 'id desc'
    )
  }

  it "connect to database" do
    0.should == 0
    #@export.export_lines{|csv_row| p csv_row}
    @export.export_to_csv("/tmp/1111.csv")
  end

end

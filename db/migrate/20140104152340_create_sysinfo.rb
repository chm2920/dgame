class CreateSysinfo < ActiveRecord::Migration
  def change
    create_table :sysinfos do |t|
      t.string :round_no
      t.datetime :started_at
      t.string :game_status
      t.string :timeout
    end
    
    Sysinfo.create(:round_no => 1, :started_at => Time.now, :game_status => "stopped", :timeout => "240s")
  end
end

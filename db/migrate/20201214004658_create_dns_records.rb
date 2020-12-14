class CreateDnsRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :dns_records do |t|
      t.references :ip_address, null: false, foreign_key: true
      t.references :domain_name, null: false, foreign_key: true

      t.timestamps
    end
  end
end

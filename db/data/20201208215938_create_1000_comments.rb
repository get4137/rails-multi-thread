class Create1000Comments < ActiveRecord::Migration[6.0]
  def up
    1.upto(1000).each do |n|
      Comment.create(body: n)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

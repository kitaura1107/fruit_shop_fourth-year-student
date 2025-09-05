class ChangeStatusDefaultInProducts < ActiveRecord::Migration[8.0]
  def up
    # 1. NULLのものを0（on_sale）に置換
    execute <<-SQL.squish
      UPDATE products
      SET status = 0
      WHERE status IS NULL
    SQL

    # 2. デフォルト値を設定
    change_column_default :products, :status, 0

    # 3. null制約を追加
    change_column_null :products, :status, false
  end

  def down
    change_column_null :products, :status, true
    change_column_default :products, :status, nil
  end
end

class Coin < ApplicationRecord

  def self.new_coin(code)
    begin
      looked_up = ISO4217::Currency.from_code(code)
      new(code: looked_up.code, name: looked_up.name, symbol: looked_up.symbol)
    rescue Exception => e
      return nil
    end
  end
end

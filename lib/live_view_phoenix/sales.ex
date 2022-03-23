defmodule LiveViewPhoenix.Sales do
  def new_orders do
    Enum.random(5..20)
  end

  def sales_amout do
    Enum.random(100..1000)
  end

  def satisfaction do
    Enum.random(95..100)
  end
end

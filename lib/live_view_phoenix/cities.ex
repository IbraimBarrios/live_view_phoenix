defmodule LiveViewPhoenix.Cities do
  def suggest(""), do: []

  def suggest(prefix) do
     Enum.filter(list_cities(), &has_prefix?(&1, prefix))
  end

  defp has_prefix?(city, prefix) do
    String.starts_with?(String.downcase(city), String.downcase(prefix))
  end


  def list_cities do
    [
      "Alabama, AL",
      "Alaska, AK",
      "Arizona, AZ",
      "Arkansas, AR",
      "California, CA",
      "Colorado, CO",
      "Conneticut, CT",
      "Deleware, DE",
      "Florida, FL",
      "Georgia, GA",
      "Hawaii, HI",
      "Idaho, ID",
      "Illinois, IL",
      "Indiana, IN",
      "Iowa, IA",
      "Indianapolis, IN",
      "Atlanta, GA",
      "Chicago, IL"
    ]
  end

end

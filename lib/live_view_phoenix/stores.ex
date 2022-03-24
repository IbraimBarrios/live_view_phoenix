defmodule LiveViewPhoenix.Stores do
  def search_by_zip(zip) do
    :timer.sleep(2000) #timpo de respuesta de 2 segundos
    list_stores()
    |> Enum.filter(&(&1.zip == zip))
  end

  def search_by_city(city) do
    list_stores()
    |> Enum.filter(&(&1.city == city))
  end

  def list_stores do
    [
      %{
        name: "Downtown Helena",
        street: "312 Montana Avenida",
        phone_number: "406-555-0100",
        city: "Helena, MT",
        zip: "59602",
        open: true,
        hours: "8am - 10pm M-F"
      },
      %{
        name: "The Source",
        street: "Jr Blvd",
        phone_number: "765-877-9890",
        city: "Demver, CO",
        zip: "80201",
        open: false,
        hours: "8am - 7pm M-F"
      },
      %{
        name: "Las Rosas",
        street: "W 41 st st avenida",
        phone_number: "535-745-0875",
        city: "Miami, FL",
        zip: "33124",
        open: true,
        hours: "8am - 6pm M-F"
      },
      %{
        name: "Valero",
        street: "Us 441 s avenida",
        phone_number: "576-979-0981",
        city: "Orlando, FL",
        zip: "33124",
        open: true,
        hours: "9am - 6pm M-F"
      },
      %{
        name: "Kroger",
        street: "Lawrence",
        phone_number: "564-132-7543",
        city: "Indianapolis, IN",
        zip: "46201",
        open: true,
        hours: "8am - 8pm M-F"
      },
      %{
        name: "Chai Pani",
        street: "E ponce de leon avenida",
        phone_number: "575-232-7823",
        city: "Atlanta, GA",
        zip: "30301",
        open: true,
        hours: "8am - 9pm M-F"
      },
      %{
        name: "vitue",
        street: "s Harper avenida",
        phone_number: "647-533-0973",
        city: "Chicago, IL",
        zip: "60601",
        open: true,
        hours: "8am - 9pm M-F"
      }
    ]
  end


end

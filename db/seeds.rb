# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

urls = [
  "https://realtor.p.rapidapi.com/properties/v2/list-for-rent?sort=relevance&postal_code=78701&prop_type=apartment&limit=200&offset=0",
  "https://realtor.p.rapidapi.com/properties/v2/list-for-rent?sort=relevance&postal_code=78741&prop_type=apartment&limit=200&offset=0",
  "https://realtor.p.rapidapi.com/properties/v2/list-for-rent?sort=relevance&postal_code=78704&prop_type=apartment&limit=200&offset=0",
  "https://realtor.p.rapidapi.com/properties/v2/list-for-rent?sort=relevance&postal_code=78705&prop_type=apartment&limit=200&offset=0",
  "https://realtor.p.rapidapi.com/properties/v2/list-for-rent?sort=relevance&postal_code=78702&prop_type=apartment&limit=200&offset=0",
  "https://realtor.p.rapidapi.com/properties/v2/list-for-rent?sort=relevance&postal_code=78722&prop_type=apartment&limit=200&offset=0",
  "https://realtor.p.rapidapi.com/properties/v2/list-for-rent?sort=relevance&postal_code=78703&prop_type=apartment&limit=200&offset=0",
]

for url in urls
  response = RestClient.get(
    url,
    :content_type => :json,
    :accept => :json,
    :'X-RapidAPI-Host' => "realtor.p.rapidapi.com",
    :'X-RapidAPI-Key' => "797e852795mshd1788cc7a741491p138d54jsne9ad2d1bbabf",
  )

  parsed = JSON.parse(response)

  apartments = parsed["properties"]

  for apartment in apartments
    split = apartment["address"]["line"].split(" ")

    if (apartment["address"]["line"].include?("Unit") || apartment["address"]["line"].include?("Apt"))
      unit = split[-2] + " " + split[-1]
      street = split[0..-3]
      street = street.join(" ")
      price_min = nil
      price_max = nil
      name = nil

      if (apartment.has_key?("community"))
        name = apartment["community"]["name"]
        price_min = apartment["community"]["price_min"]
        price_max = apartment["community"]["price_max"]
        apt = Apartment.create(unit: unit)
      else
        apt = Apartment.create(unit: unit, price: apartment["price"])
      end
    else
      if apartment.has_key?("community")
        Property.create(
          address: apartment["address"]["line"],
          price_min: apartment["community"]["price_min"],
          price_max: apartment["community"]["price_max"],
          latitude: apartment["address"]["lat"],
          longitude: apartment["address"]["lon"],
          name: apartment["community"]["name"],
          zip: apartment["address"]["postal_code"],
          phone: apartment["community"]["contact_number"],
          cat_friendly: apartment["client_display_flags"]["allows_cats"],
          dog_friendly: apartment["client_display_flags"]["allows_dogs"],
          neighborhood: apartment["address"]["neighborhood_name"],
          year_built: apartment["year_built"],
        )
      else
        Property.create(
          address: apartment["address"]["line"],
          price_min: nil,
          price_max: nil,
          latitude: apartment["address"]["lat"],
          longitude: apartment["address"]["lon"],
          name: nil,
          zip: apartment["address"]["postal_code"],
          cat_friendly: apartment["client_display_flags"]["allows_cats"],
          dog_friendly: apartment["client_display_flags"]["allows_dogs"],
          neighborhood: apartment["address"]["neighborhood_name"],
          year_built: apartment["year_built"],
        )
      end
      next
    end

    property_found = false
    for property in Property.all
      if (property.address === street)
        property.apartments << apt

        if (property.images.length === 0 && apartment["photos"].length != 0)
          for image in apartment["photos"]
            Image.create(
              property_id: property.id,
              image: image["href"],
            )
          end
        end
        property_found = true
        break
      end
    end

    if (!property_found)
      prop = Property.create(
        address: apartment["address"]["line"],
        price_min: nil,
        price_max: nil,
        latitude: apartment["address"]["lat"],
        longitude: apartment["address"]["lon"],
        name: nil,
        zip: apartment["address"]["postal_code"],
        cat_friendly: apartment["client_display_flags"]["allows_cats"],
        dog_friendly: apartment["client_display_flags"]["allows_dogs"],
        neighborhood: apartment["address"]["neighborhood_name"],
        year_built: apartment["year_built"],
      )

      prop.apartments << apt

      for image in apartment["photos"]
        Image.create(
          property_id: prop.id,
          image: image["href"],
        )
      end
    end
  end
end

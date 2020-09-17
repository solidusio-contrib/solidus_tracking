# frozen_string_literal: true

module SolidusTracking
  module Serializer
    class Address < Base
      def address
        object
      end

      def as_json(_options = {})
        return unless address

        if address.respond_to?(:name)
          first_name, last_name = address.name.split(' ', 2)
          full_name = address.name
        else
          first_name = address.firstname
          last_name = address.lastname
          full_name = "#{address.first_name} #{address.last_name}"
        end

        {
          'FullName' => full_name,
          'FirstName' => first_name,
          'LastName' => last_name,
          'Company' => address.company,
          'Address1' => address.address1,
          'Address2' => address.address2,
          'City' => address.city,
          'Region' => address.state_text,
          'RegionCode' => address.state.abbr,
          'Country' => address.country.name,
          'CountryCode' => address.country.iso,
          'Zip' => address.zipcode,
          'Phone' => address.phone,
        }
      end
    end
  end
end

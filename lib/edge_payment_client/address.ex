defmodule EdgePaymentClient.Address do
  import EdgePaymentClient.Resource, only: :macros

  @path "/consumer_addresses"
  @resource_type "consumer_addresses"
  @enforce_keys [
    :id,
    :type,
    :line_1,
    :city,
    :state,
    :zip,
    :country,
    :created_at,
    :updated_at,
    :__record__,
    :__included__,
    :__meta__
  ]
  defstruct id: nil,
            type: @resource_type,
            line_1: nil,
            city: nil,
            state: nil,
            zip: nil,
            country: nil,
            created_at: nil,
            updated_at: nil,
            __record__: nil,
            __included__: [],
            __meta__: %{}

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          line_1: String.t(),
          city: String.t(),
          state: String.t(),
          zip: String.t(),
          country: String.t(),
          created_at: String.t(),
          updated_at: String.t(),
          __record__: map(),
          __included__: list(map()),
          __meta__: map()
        }


  with_list()
  with_show()
  with_create()
  with_update()
  with_delete()

  defp struct_from_entity(
         %{
           "id" => id,
           "attributes" => %{
             "line_1" => line_1,
             "city" => city,
             "state" => state,
             "zip" => zip,
             "country" => country,
             "created_at" => created_at,
             "updated_at" => updated_at
           }
         } = record,
         included,
         meta
       ) do
    %__MODULE__{
      id: id,
      type: @resource_type,
      line_1: line_1,
      city: city,
      state: state,
      zip: zip,
      country: country,
      # TODO: Parse date time
      created_at: created_at,
      updated_at: updated_at,
      __included__: included,
      __meta__: meta,
      __record__: record
    }
  end
end

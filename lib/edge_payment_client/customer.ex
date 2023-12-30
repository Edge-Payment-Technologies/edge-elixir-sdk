defmodule EdgePaymentClient.Customer do
  import EdgePaymentClient.Resource, only: :macros

  @path "/customers"
  @resource_type "customers"
  @enforce_keys [
    :id,
    :type,
    :name,
    :created_at,
    :updated_at,
    :__record__,
    :__included__,
    :__meta__
  ]
  defstruct id: nil,
            type: @resource_type,
            name: nil,
            created_at: nil,
            updated_at: nil,
            __record__: nil,
            __included__: [],
            __meta__: %{}

  @type t() :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          name: String.t(),
          #  TODO: Change to date time
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
             "name" => name,
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
      name: name,
      # TODO: Parse date time
      created_at: created_at,
      updated_at: updated_at,
      __included__: included,
      __meta__: meta,
      __record__: record
    }
  end
end

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
  # @spec delete(EdgePaymentClient.t(), t()) :: nil
  # def delete(client, record)
  #     when is_struct(client, EdgePaymentClient) and is_struct(record, __MODULE__) do
  # end

  # @spec update(EdgePaymentClient.t(), t(), map()) :: nil
  # def update(client, record, attributes, relationships \\ nil)
  #     when is_struct(client, EdgePaymentClient) and is_struct(record, __MODULE__) and
  #            is_map(attributes) do
  #   client
  #   |> EdgePaymentClient.patch("#{@path}/#{record.id}", %{
  #     data: %{
  #       type: @resource_type,
  #       attributes: attributes,
  #       relationships: relationships |> Enum.map(&EdgePaymentClient.encode_relation/1)
  #     }
  #   })
  #   |> case do
  #     {:ok,
  #      %{
  #        json:
  #          %{
  #            "data" => entity
  #          } = payload
  #      }} ->
  #       struct_from_entity(entity, payload["included"], payload["meta"])

  #     error ->
  #       error
  #   end
  # end

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

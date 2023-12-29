defmodule EdgePaymentClient.Address do
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

  @spec list(EdgePaymentClient.t()) :: nil
  def list(client) when is_struct(client, EdgePaymentClient) do
  end

  @spec show(EdgePaymentClient.t(), String.t()) :: nil
  def show(client, id) when is_struct(client, EdgePaymentClient) and is_binary(id) do
  end

  @spec create(EdgePaymentClient.t(), map()) :: t() | {:error, any()}
  def create(client, attributes)
      when is_struct(client, EdgePaymentClient) and is_map(attributes) do
    client
    |> EdgePaymentClient.post("#{@path}", %{
      data: %{
        type: @resource_type,
        attributes: attributes
      }
    })
    |> case do
      {:ok,
       %{
         json:
           %{
             "data" => entity
           } = payload
       }} ->
        struct_from_entity(entity, payload["included"], payload["meta"])

      error ->
        error
    end
  end

  @spec delete(EdgePaymentClient.t(), t()) :: nil
  def delete(client, record)
      when is_struct(client, EdgePaymentClient) and is_struct(record, __MODULE__) do
  end

  @spec update(EdgePaymentClient.t(), t(), map()) :: nil
  def update(client, record, attributes)
      when is_struct(client, EdgePaymentClient) and is_struct(record, __MODULE__) and
             is_map(attributes) do
  end

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

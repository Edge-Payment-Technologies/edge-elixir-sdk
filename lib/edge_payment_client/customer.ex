defmodule EdgePaymentClient.Customer do
  @enforce_keys [:id, :name, :created_at, :updated_at, :__record__]
  defstruct id: nil, name: nil, created_at: nil, updated_at: nil, __record__: nil

  @path "/customers"
  @resource_type "customers"

  @type t() :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          #  TODO: Change to date time
          created_at: String.t(),
          updated_at: String.t(),
          __record__: map()
        }

  @spec list(EdgePaymentClient.t(), Keyword.t() | nil) :: list(t()) | {:error, any()}
  def list(client, query \\ [])
      when is_struct(client, EdgePaymentClient) do
    client
    |> EdgePaymentClient.get("#{@path}", query)
    |> case do
      {:ok,
       %{
         json: %{
           "data" => entities
         }
       }} ->
        Enum.map(entities, &struct_from_entity/1)

      error ->
        error
    end
  end

  @spec show(EdgePaymentClient.t(), String.t()) :: t() | nil | {:error, any()}
  def show(client, id) when is_struct(client, EdgePaymentClient) and is_binary(id) do
    client
    |> EdgePaymentClient.get("#{@path}/#{id}")
    |> case do
      {:ok,
       %{
         json: %{
           "data" => entity
         }
       }} ->
        struct_from_entity(entity)

      error ->
        error
    end
  end

  @spec create(EdgePaymentClient.t(), map) :: t() | {:error, any()}
  def create(client, attributes)
      when is_struct(client, EdgePaymentClient) and is_map(attributes) do
    client
    |> EdgePaymentClient.post("#{@path}", %{data: %{type: @resource_type, attributes: attributes}})
    |> case do
      {:ok,
       %{
         json: %{
           "data" => entity
         }
       }} ->
        struct_from_entity(entity)

      error ->
        error
    end
  end

  # @spec delete(EdgePaymentClient.t(), t()) :: nil
  # def delete(client, record)
  #     when is_struct(client, EdgePaymentClient) and is_struct(record, __MODULE__) do
  # end

  # @spec update(EdgePaymentClient.t(), t(), map()) :: nil
  # def update(client, record, attributes)
  #     when is_struct(client, EdgePaymentClient) and is_struct(record, __MODULE__) and
  #            is_map(attributes) do
  # end

  defp struct_from_entity(
         %{
           "id" => id,
           "attributes" => %{"name" => name, "created_at" => created_at, "updated_at" => updated_at}
         } = record
       ) do
    %__MODULE__{
      id: id,
      name: name,
      # TODO: Parse date time
      created_at: created_at,
      updated_at: updated_at,
      __record__: record
    }
  end
end

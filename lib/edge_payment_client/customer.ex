defmodule EdgePaymentClient.Customer do
  @enforce_keys [:id, :created_at, :updated_at, :__record__]
  defstruct id: nil, created_at: nil, updated_at: nil, __record__: nil

  @path "/customers"

  @type t() :: %__MODULE__{
          id: String.t(),
          #  TODO: Change to date time
          created_at: String.t(),
          updated_at: String.t(),
          __record__: map()
        }

  @spec list(EdgePaymentClient.t(), map(), list(), list()) :: t() | nil
  def list(client, filters \\ %{}, include \\ [], fields \\ [], sort \\ [])
      when is_struct(client, EdgePaymentClient) do
    client
    |> EdgePaymentClient.get("#{@path}", %{
      "filter" => filters,
      "fields" => Enum.join(fields, ","),
      "include" => Enum.join(include, ","),
      "sort" => Enum.join(sort, ",")
    })
    |> case do
      {:ok,
       %{
         json: %{
            "data" => records
          }
       }} ->
        Enum.map(records, fn %{
            "id" => id,
            "attributes" => %{"created_at" => created_at, "updated_at" => updated_at}
          } = record ->
          %__MODULE__{
            id: id,

            # TODO: Parse date time
            created_at: created_at,
            updated_at: updated_at,
            __record__: record
          }
        end)

      error -> error
    end
  end

  @spec show(EdgePaymentClient.t(), String.t()) :: nil
  def show(client, id) when is_struct(client, EdgePaymentClient) and is_binary(id) do
  end

  @spec create(EdgePaymentClient.t(), map) :: nil
  def create(client, attributes)
      when is_struct(client, EdgePaymentClient) and is_map(attributes) do
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
end

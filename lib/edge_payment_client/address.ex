defmodule EdgePaymentClient.Address do
  defstruct id: nil, customer_id: nil, created_at: nil, updated_at: nil

  @type t() :: %__MODULE__{
          id: String.t(),
          customer_id: String.t(),
          created_at: String.t(),
          updated_at: String.t()
        }

  @spec list(EdgePaymentClient.t()) :: nil
  def list(client) when is_struct(client, EdgePaymentClient) do
  end

  @spec show(EdgePaymentClient.t(), String.t()) :: nil
  def show(client, id) when is_struct(client, EdgePaymentClient) and is_binary(id) do
  end

  @spec create(EdgePaymentClient.t(), map) :: nil
  def create(client, attributes)
      when is_struct(client, EdgePaymentClient) and is_map(attributes) do
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
end

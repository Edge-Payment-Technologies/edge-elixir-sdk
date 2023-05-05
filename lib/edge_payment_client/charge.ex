defmodule EdgePaymentClient.Charge do
  defstruct id: nil,
            customer_id: nil,
            payment_method_id: nil,
            subscription_id: nil,
            status: nil,
            message_type_id: nil,
            amount: nil,
            fee: nil,
            net: nil,
            currency: nil,
            description: nil,
            transaction_time: nil,
            billing_address_id: nil,
            shipping_address_id: nil,
            is_production: false,
            created_at: nil,
            updated_at: nil

  @type t() :: %__MODULE__{
          id: String.t(),
          customer_id: String.t(),
          payment_method_id: String.t(),
          subscription_id: String.t() | nil,
          status: String.t(),
          message_type_id: String.t(),
          amount: integer(),
          fee: integer(),
          net: integer(),
          currency: String.t(),
          description: String.t(),
          transaction_time: String.t(),
          billing_address_id: String.t(),
          shipping_address_id: String.t() | nil,
          is_production: boolean(),
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

  @spec update(EdgePaymentClient.t(), t(), map()) :: nil
  def update(client, record, attributes)
      when is_struct(client, EdgePaymentClient) and is_struct(record, __MODULE__) and
             is_map(attributes) do
  end

  @spec complete(EdgePaymentClient.t(), t()) :: nil
  def complete(client, record)
      when is_struct(client, EdgePaymentClient) and is_struct(record, __MODULE__) do
  end
end

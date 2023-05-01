defmodule EdgePaymentClient.WebhookDelivery do
  defstruct id: nil

  @type t() :: %__MODULE__{
          id: String.t()
        }

  @spec list(EdgePaymentClient.t()) :: nil
  def list(client) when is_struct(client, EdgePaymentClient) do
  end

  @spec show(EdgePaymentClient.t(), String.t()) :: nil
  def show(client, id) when is_struct(client, EdgePaymentClient) and is_binary(id) do
  end
end

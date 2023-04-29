defmodule EdgePaymentClient do
  defstruct authorization: nil, json_parser: &Jason.decode/1, host: "api.tryedge.com"

  @type t() :: %__MODULE__{
    authorization: String.t(),
    json_parser: (String.t() -> any()),
    host: String.t()
  }

  @spec client(map()) :: %EdgePaymentClient{authorization: String.t()}
  def client(properties) when is_map(properties) do
    %__MODULE__{
      authorization: "Bearer #{properties[:token]}",
      json_parser: properties[:json_parser],
      host: properties[:host]
    }
  end

  @spec get(EdgePaymentClient.t(), String.t(), map()) :: 2
  def get(client, path, data) when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    1 + 1
  end

  @spec options(EdgePaymentClient.t(), String.t(), map()) :: 2
  def options(client, path, data) when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    1 + 1
  end

  @spec delete(EdgePaymentClient.t(), String.t(), map()) :: 2
  def delete(client, path, data) when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    1 + 1
  end

  @spec post(EdgePaymentClient.t(), String.t(), map()) :: 2
  def post(client, path, data) when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    1 + 1
  end

  @spec patch(EdgePaymentClient.t(), String.t(), map()) :: 2
  def patch(client, path, data) when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    1 + 1
  end

  @spec put(EdgePaymentClient.t(), String.t(), map()) :: 2
  def put(client, path, data) when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    1 + 1
  end
end

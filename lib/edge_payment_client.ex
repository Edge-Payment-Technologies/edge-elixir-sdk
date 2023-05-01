defmodule EdgePaymentClient do
  defstruct authorization: nil,
            json_decoder: &Jason.decode/1,
            json_encoder: &Jason.encode/1,
            host: "api.tryedge.com",
            user_agent: nil

  @type t() :: %__MODULE__{
          authorization: String.t(),
          json_decoder: (String.t() -> {:ok, any()} | {:error, any()}),
          json_encoder: (any() -> {:ok, String.t()} | {:error, any()}),
          host: String.t(),
          user_agent: String.t() | nil
        }

  @default_headers []

  @spec client(map()) :: %EdgePaymentClient{authorization: String.t()}
  def client(properties) when is_map(properties) do
    %__MODULE__{
      authorization: "Bearer #{properties[:token]}",
      json_decoder: properties[:json_decoder],
      json_encoder: properties[:json_encoder],
      host: properties[:host]
    }
  end

  @spec get(EdgePaymentClient.t(), String.t(), map()) :: {:ok, any()}
  def get(client, path, data)
      when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    Finch.build(
      :get,
      encode_with_query(client.host, path, data),
      default_headers(client, [
        {"Accept", "application/vnd.api+json"}
      ])
    )
    |> Finch.request(:client)
    |> case do
      {:ok, response} -> response.body
        |> client.json_decoder.()
      error ->
        error
    end
  end

  @spec options(EdgePaymentClient.t(), String.t(), map()) :: {:ok, any()}
  def options(client, path, data)
      when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    Finch.build(
      :options,
      encode_with_query(client.host, path, data),
      default_headers(client)
    )
    |> Finch.request(:client)
  end

  @spec delete(EdgePaymentClient.t(), String.t(), map()) :: {:ok, any()}
  def delete(client, path, data)
      when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    Finch.build(
      :delete,
      encode_with_query(client.host, path, data),
      default_headers(client)
    )
    |> Finch.request(:client)
  end

  @spec post(EdgePaymentClient.t(), String.t(), map()) :: {:ok, any()}
  def post(client, path, data)
      when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    data
    |> client.json_encoder.()
    |> case do
      {:ok, payload} ->
        Finch.build(
          :post,
          encode_without_query(client.host, path),
          default_headers(client, [
            {"Content-Type", "application/vnd.api+json"},
            {"Accept", "application/vnd.api+json"}
          ]),
          payload
        )
        |> Finch.request(:client)
        |> case do
          {:ok, response} -> response.body
            |> client.json_decoder.()
          error ->
            error
        end

      error ->
        error
    end
  end

  @spec patch(EdgePaymentClient.t(), String.t(), map()) :: {:ok, any()}
  def patch(client, path, data)
      when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    data
    |> client.json_encoder.()
    |> case do
      {:ok, payload} ->
        Finch.build(
          :patch,
          encode_without_query(client.host, path),
          default_headers(client, [
            {"Content-Type", "application/vnd.api+json"},
            {"Accept", "application/vnd.api+json"}
          ]),
          payload
        )
        |> Finch.request(:client)
        |> case do
          {:ok, response} -> response.body
            |> client.json_decoder.()
          error ->
            error
        end

      error ->
        error
    end
  end

  @spec put(EdgePaymentClient.t(), String.t(), map()) :: {:ok, any()}
  def put(client, path, data)
      when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    data
    |> client.json_encoder.()
    |> case do
      {:ok, payload} ->
        Finch.build(
          :put,
          encode_without_query(client.host, path),
          default_headers(client, [
            {"Content-Type", "application/vnd.api+json"},
            {"Accept", "application/vnd.api+json"}
          ]),
          payload
        )
        |> Finch.request(:client)
        |> case do
          {:ok, response} -> response.body
            |> client.json_decoder.()
          error ->
            error
        end

      error ->
        error
    end
  end

  defp encode_without_query(host, path)
       when is_binary(host) and is_binary(path),
       do: encode_without_query(URI.parse(host), URI.parse(path))

  defp encode_without_query(host, path)
       when is_struct(host, URI) and is_struct(path, URI),
       do: URI.merge(host, path)

  defp encode_with_query(host, path, query)
       when is_binary(host) and is_binary(path) and is_map(query),
       do: encode_with_query(URI.parse(host), URI.parse(path), URI.encode_query(query, :rfc3986))

  defp encode_with_query(host, path, query)
       when is_struct(host, URI) and is_struct(path, URI) and is_binary(query),
       do: URI.merge(URI.merge(host, path), %URI{query: query})

  defp default_headers(%EdgePaymentClient{user_agent: user_agent, authorization: authorization}, custom_headers \\ [])
       when is_binary(user_agent) and is_list(custom_headers) do
    @default_headers
    |> Enum.concat([
      {"User-Agent", Enum.join(["Edge Payment Client/1.0.0", user_agent], " ")},
      {"Authorization", authorization}
    ])
    |> Enum.concat(custom_headers)
  end
end

defmodule EdgePaymentClient do
  @enforce_keys [
    :authorization,
    :user_agent,
    :host,
    :json_decoder,
    :json_encoder,
    :namespace,
    :finch_options
  ]
  defstruct authorization: nil,
            user_agent: nil,
            host: "api.tryedge.com",
            json_decoder: &Jason.decode/1,
            json_encoder: &Jason.encode/1,
            namespace: EdgePaymentClient.Finch,
            finch_options: []

  @default_query_options %{
    filters: %{},
    include: [],
    sort: [],
    page: [],
    fields: %{}
  }

  @type raw() :: %{
          token: String.t(),
          user_agent: String.t(),
          json_decoder: function() | nil,
          json_ecoder: function() | nil,
          host: String.t() | nil,
          namespace: atom() | nil
        }
  @type t() :: %__MODULE__{
          authorization: String.t(),
          json_decoder: (String.t() -> {:ok, any()} | {:error, any()}),
          json_encoder: (any() -> {:ok, String.t()} | {:error, any()}),
          host: String.t(),
          user_agent: String.t(),
          finch_options: Keyword.t(),
          namespace: atom()
        }

  @default_headers []

  @spec client(raw()) :: t()
  def client(%{token: token, user_agent: user_agent} = properties) when is_map(properties) do
    struct(
      __MODULE__,
      %{
        authorization: "Bearer #{token}",
        user_agent: user_agent
      }
      |> Map.merge(properties)
    )
  end

  @spec get(EdgePaymentClient.t(), String.t(), Keyword.t() | nil) ::
          {:ok, any()} | {:error, any()}
  def get(client, path, query \\ [])
      when is_struct(client, EdgePaymentClient) and is_binary(path) do
    Finch.build(
      :get,
      encode_uri(client.host, path, with_query_defaults(query)),
      default_headers(client, [
        {"Accept", "application/vnd.api+json"}
      ])
    )
    |> request(client)
    |> response(client)
  end

  @spec options(EdgePaymentClient.t(), String.t(), Keyword.t() | nil) :: {:ok, any()}
  def options(client, path, query \\ [])
      when is_struct(client, EdgePaymentClient) and is_binary(path) do
    Finch.build(
      :options,
      encode_uri(client.host, path, with_query_defaults(query)),
      default_headers(client)
    )
    |> request(client)
    |> response(client)
  end

  @spec delete(EdgePaymentClient.t(), String.t(), Keyword.t() | nil) :: {:ok, any()}
  def delete(client, path, query \\ [])
      when is_struct(client, EdgePaymentClient) and is_binary(path) do
    Finch.build(
      :delete,
      encode_uri(client.host, path, with_query_defaults(query)),
      default_headers(client)
    )
    |> request(client)
    |> response(client)
  end

  @spec post(EdgePaymentClient.t(), String.t(), map(), Keyword.t() | nil) ::
          {:ok, any()} | {:error}
  def post(client, path, data, query \\ [])
      when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    data
    |> client.json_encoder.()
    |> case do
      {:ok, payload} ->
        Finch.build(
          :post,
          encode_uri(client.host, path, with_query_defaults(query)),
          default_headers(client, [
            {"Content-Type", "application/vnd.api+json"},
            {"Accept", "application/vnd.api+json"}
          ]),
          payload
        )
        |> request(client)
        |> response(client)

      error ->
        error
    end
  end

  @spec patch(EdgePaymentClient.t(), String.t(), map(), Keyword.t() | nil) :: {:ok, any()}
  def patch(client, path, data, query \\ [])
      when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    data
    |> client.json_encoder.()
    |> case do
      {:ok, payload} ->
        Finch.build(
          :patch,
          encode_uri(client.host, path, with_query_defaults(query)),
          default_headers(client, [
            {"Content-Type", "application/vnd.api+json"},
            {"Accept", "application/vnd.api+json"}
          ]),
          payload
        )
        |> request(client)
        |> response(client)

      error ->
        error
    end
  end

  @spec put(EdgePaymentClient.t(), String.t(), map(), Keyword.t() | nil) :: {:ok, any()}
  def put(client, path, data, query \\ [])
      when is_struct(client, EdgePaymentClient) and is_binary(path) and is_map(data) do
    data
    |> client.json_encoder.()
    |> case do
      {:ok, payload} ->
        Finch.build(
          :put,
          encode_uri(client.host, path, with_query_defaults(query)),
          default_headers(client, [
            {"Content-Type", "application/vnd.api+json"},
            {"Accept", "application/vnd.api+json"}
          ]),
          payload
        )
        |> request(client)
        |> response(client)

      error ->
        error
    end
  end

  defp encode_uri(host, path, nil)
       when is_binary(host) and is_binary(path),
       do:
         encode_uri(
           URI.parse("https://#{host}"),
           URI.parse(path),
           nil
         )

  defp encode_uri(host, path, nil)
       when is_struct(host, URI) and is_struct(path, URI),
       do: URI.parse("#{host}#{path}")

  defp encode_uri(host, path, query)
       when is_binary(host) and is_binary(path) and is_map(query),
       do:
         encode_uri(
           URI.parse("https://#{host}"),
           URI.parse(path),
           Plug.Conn.Query.encode(query)
         )

  defp encode_uri(host, path, query)
       when is_struct(host, URI) and is_struct(path, URI) and is_binary(query),
       do: URI.parse("#{host}#{path}?#{query}")

  defp default_headers(
         %EdgePaymentClient{user_agent: user_agent, authorization: authorization},
         custom_headers \\ []
       )
       when is_binary(user_agent) and is_list(custom_headers) do
    @default_headers
    |> Enum.concat([
      {"User-Agent", Enum.join(["Edge Payment Client/1.0.0", user_agent], " ")},
      {"Authorization", authorization}
    ])
    |> Enum.concat(custom_headers)
  end

  defp request(finch_client, edge_client),
    do: finch_client |> Finch.request(edge_client.namespace, edge_client.finch_options)

  defp response({:ok, %Finch.Response{status: 403} = response}, _edge_client) do
    {:error, response}
  end

  defp response({:ok, %Finch.Response{status: 401} = response}, _edge_client) do
    {:error, response}
  end

  defp response({:ok, %Finch.Response{body: ""} = response}, _edge_client) do
    {:ok, %{response: response, json: nil}}
  end

  defp response({:ok, %Finch.Response{status: 422, body: body} = response}, edge_client) do
    edge_client.json_decoder.(body)
    |> case do
      {:ok, json} -> {:error, %{response: response, json: json}}
      {:error, decoding_error} -> {:error, %{response: response, json: decoding_error}}
    end
  end

  defp response({:ok, %Finch.Response{body: body} = response}, edge_client) do
    edge_client.json_decoder.(body)
    |> case do
      {:ok, json} -> {:ok, %{response: response, json: json}}
      {:error, decoding_error} -> {:error, %{response: response, json: decoding_error}}
    end
  end

  defp response({:error, %Finch.Response{} = response}, _edge_client) do
    {:error, response}
  end

  defp response({:error, error}, _edge_client) do
    {:error, error}
  end

  defp with_query_defaults(nil), do: nil
  defp with_query_defaults([]), do: nil

  defp with_query_defaults(query) when is_list(query) do
    %{
      filter: query |> Keyword.get(:filter, @default_query_options[:filter]),
      fields:
        query
        |> Keyword.get(:fields, @default_query_options[:fields])
        |> encode_fields_query(),
      sort: query |> Keyword.get(:sort, @default_query_options[:sort]) |> Enum.join(","),
      page: query |> Keyword.get(:page, @default_query_options[:page]),
      include: query |> Keyword.get(:include, @default_query_options[:include]) |> Enum.join(",")
    }
    |> Enum.filter(fn
      {_key, %{}} -> false
      {_key, []} -> false
      {_key, ""} -> false
      {_key, nil} -> false
      {_key, _value} -> true
    end)
    |> Map.new()
  end

  defp with_query_defaults(%{}), do: %{}
  defp encode_fields_query(fields) when is_map(fields) do
    fields
    |> Enum.map(fn {resource, attributes} when is_list(attributes) -> {resource, Enum.join(attributes, ",")} end)
    |> Map.new()
  end
end

defmodule EPTSDK do
  @default_query_options %{
    filter: %{},
    include: [],
    sort: [],
    page: [],
    fields: %{}
  }
  @enforce_keys [
    :authorization,
    :user_agent,
    :location,
    :http_client
  ]
  @default_headers []

  defstruct authorization: nil,
            user_agent: nil,
            location: %URI{scheme: "https", host: "api.tryedge.io"},
            http_client: Req.new(),
            response: nil,
            links: nil,
            meta: nil

  @type t() :: %__MODULE__{
          authorization: String.t(),
          user_agent: String.t(),
          location: URI.t() | String.t(),
          http_client: Req.t()
        }

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

  def get(%EPTSDK{location: location} = client, path, query \\ [])
      when is_binary(path) do
    client.http_client
    |> Req.get(
      url: encode_uri(location, path, with_query_defaults(query)),
      headers:
        default_headers(client, [
          {"Accept", "application/vnd.api+json"}
        ])
    )
    |> response()
  end

  def delete(%EPTSDK{location: location} = client, path, query \\ [])
      when is_binary(path) do
    client.http_client
    |> Req.delete(
      url: encode_uri(location, path, with_query_defaults(query)),
      headers: default_headers(client)
    )
    |> response()
  end

  def post(%EPTSDK{location: location} = client, path, data, query \\ [])
      when is_binary(path) and is_map(data) do
    client.http_client
    |> Req.post(
      url: encode_uri(location, path, with_query_defaults(query)),
      headers:
        default_headers(client, [
          {"Content-Type", "application/vnd.api+json"},
          {"Accept", "application/vnd.api+json"}
        ]),
      json: dbg(data)
    )
    |> response()
  end

  def patch(%EPTSDK{location: location} = client, path, data, query \\ [])
      when is_binary(path) and is_map(data) do
    client.http_client
    |> Req.patch(
      url: encode_uri(location, path, with_query_defaults(query)),
      headers:
        default_headers(client, [
          {"Content-Type", "application/vnd.api+json"},
          {"Accept", "application/vnd.api+json"}
        ]),
      json: data
    )
    |> response()
  end

  def put(%EPTSDK{location: location} = client, path, data, query \\ [])
      when is_binary(path) and is_map(data) do
    client.http_client
    |> Req.put(
      url: encode_uri(location, path, with_query_defaults(query)),
      headers:
        default_headers(client, [
          {"Content-Type", "application/vnd.api+json"},
          {"Accept", "application/vnd.api+json"}
        ]),
      json: data
    )
    |> response()
  end

  defp encode_uri(location, path, nil)
       when is_binary(location) and is_binary(path),
       do: URI.append_path(%URI{host: location, scheme: "https"}, path)

  defp encode_uri(uri, path, nil)
       when is_struct(uri, URI) and is_binary(path),
       do: URI.append_path(uri, path)

  defp encode_uri(location, path, query)
       when is_map(query),
       do:
         URI.append_query(
           encode_uri(location, path, nil),
           Plug.Conn.Query.encode(query)
         )

  defp default_headers(
         %EPTSDK{user_agent: user_agent, authorization: authorization},
         custom_headers \\ []
       )
       when is_binary(user_agent) and is_list(custom_headers) do
    @default_headers
    |> Enum.concat([
      {"User-Agent", Enum.join(["Edge Payment Client/1.0", user_agent], " ")},
      {"Authorization", authorization}
    ])
    |> Enum.concat(custom_headers)
  end

  defp response({:ok, %Req.Response{status: 422, body: body} = response}) do
    {:unprocessable_content, body, response}
  end

  defp response({:ok, %Req.Response{status: status} = response})
       when status in 400..499 do
    {:error, response}
  end

  defp response({:ok, %Req.Response{body: body} = response}) do
    {:ok, body, response}
  end

  defp response({:error, error}) do
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
      {_key, ""} -> false
      {_key, nil} -> false
      {_key, _value} -> true
    end)
    |> Map.new()
  end

  defp with_query_defaults(%{}), do: %{}

  defp encode_fields_query(fields) when is_map(fields) do
    fields
    |> Enum.map(fn {resource, fields} when is_list(fields) ->
      {resource, Enum.join(fields, ",")}
    end)
    |> Map.new()
  end

  def update_client_from_request(
        {:ok, payload, %Req.Response{} = response},
        client
      )
      when is_struct(client, EPTSDK) and is_map(payload) do
    {:ok, payload,
     %__MODULE__{
       client
       | response: response,
         links: payload["links"],
         meta: payload["meta"]
     }}
  end

  def update_client_from_request({:error, _exception} = error, _client), do: error

  def update_client_from_request(
        {:unprocessable_content, _exception, _response} = error,
        _client
      ),
      do: error

  def update_client_from_request({:decoding_error, _exception, _response} = error, _client),
    do: error

  def update_client_from_request({:error, _exception, _response} = error, _client), do: error
end

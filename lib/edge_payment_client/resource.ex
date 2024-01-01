defmodule EdgePaymentClient.Resource do
  @moduledoc """
  The basic shape of all resource requests, sliced into various common actions against resources.
  """
  @type result(entity_or_entities) ::
          {:ok, entity_or_entities, EdgePaymentClient.t()}

  @spec with_list() :: tuple()
  defmacro with_list() do
    quote location: :keep do
      @doc """
      Fetches all `#{Kernel.inspect(__MODULE__)}.t()`.

      The `options` argument can be:

        - `fields`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant_account"]
        - `sort`, ... i.e. `sort: ["-name"]
        - `filter`, ... i.e. `fields: %{name: "John"}`
      """
      @spec list(EdgePaymentClient.t(), Keyword.t() | nil) ::
              EdgePaymentClient.Resource.result(list(t())) | EdgePaymentClient.error()
      def list(client, options \\ [])
          when is_struct(client, EdgePaymentClient) do
        client
        |> EdgePaymentClient.get("#{@path}", options)
        |> EdgePaymentClient.update_client_from_request(client)
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec with_show() :: tuple()
  defmacro with_show() do
    quote location: :keep do
      @doc """
      Fetches a `#{Kernel.inspect(__MODULE__)}.t()` by `record` or by `id`.

      The `options` argument can be:

        - `fields`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant_account"]
      """
      @spec show(EdgePaymentClient.t(), String.t() | t(), Keyword.t() | nil) ::
              EdgePaymentClient.Resource.result(t() | nil) | EdgePaymentClient.error()
      def show(_, _, options \\ [])

      def show(%EdgePaymentClient{} = client, %__MODULE__{id: id}, options),
        do: show(client, id, options)

      def show(%EdgePaymentClient{} = client, id, options) when is_binary(id) do
        client
        |> EdgePaymentClient.get("#{@path}/#{id}", options)
        |> EdgePaymentClient.update_client_from_request(client)
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec with_create() :: tuple()
  defmacro with_create() do
    quote location: :keep do
      @doc """
      Creates an new `#{Kernel.inspect(__MODULE__)}.t()` with `attributes: #{Kernel.inspect(__MODULE__)}.attributes_for_create()` and `relationships:`.

      The `options` argument can also have:

        - `fields:`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include:`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant_account"]
      """
      @spec create(EdgePaymentClient.t()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.error()
      @spec create(
              EdgePaymentClient.t(),
              [
                {:attributes, __MODULE__.attributes_for_create()}
                | {:relationships, __MODULE__.relationships_for_create()}
                | EdgePaymentClient.query(),
                ...
              ]
            ) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.error()
      def create(
            %EdgePaymentClient{} = client,
            options \\ []
          )
          when is_list(options) do
        attributes = Keyword.get(options, :attributes, %{})
        relationships = Keyword.get(options, :relationships, %{})

        client
        |> EdgePaymentClient.post(
          "#{@path}",
          %{
            data: %{
              type: @resource_type,
              attributes: attributes,
              relationships:
                relationships
                |> Enum.map(&EdgePaymentClient.Resource.encode_relation/1)
                |> Map.new()
            }
          },
          options |> Keyword.drop([:attributes, :relationships])
        )
        |> EdgePaymentClient.update_client_from_request(client)
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec with_update() :: tuple()
  defmacro with_update() do
    quote location: :keep do
      @doc """
      Updates an existing `#{Kernel.inspect(__MODULE__)}.t()` with `attributes:` and `relationships:`.

      The `options` argument can also have:

        - `fields:`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include:`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant_account"]
      """
      @spec update(
              EdgePaymentClient.t(),
              t() | String.t()
            ) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.error()
      @spec update(
              EdgePaymentClient.t(),
              t() | String.t(),
              [
                {:attributes, __MODULE__.attributes_for_update()}
                | {:relationships, __MODULE__.relationships_for_update()}
                | EdgePaymentClient.query(),
                ...
              ]
            ) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.error()
      def update(
            _,
            _,
            options \\ []
          )

      def update(
            %EdgePaymentClient{} = client,
            %__MODULE__{id: id} = record,
            options
          )
          when is_list(options) do
        update(client, id, options)
      end

      def update(
            %EdgePaymentClient{} = client,
            id,
            options
          )
          when is_binary(id) and is_list(options) do
        attributes = Keyword.get(options, :attributes, %{})
        relationships = Keyword.get(options, :relationships, %{})

        client
        |> EdgePaymentClient.patch(
          "#{@path}/#{id}",
          %{
            data: %{
              type: @resource_type,
              attributes: attributes,
              relationships:
                relationships
                |> Enum.map(&EdgePaymentClient.Resource.encode_relation/1)
                |> Map.new()
            }
          },
          options
        )
        |> EdgePaymentClient.update_client_from_request(client)
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec with_delete() :: tuple()
  defmacro with_delete() do
    quote location: :keep do
      @spec delete(EdgePaymentClient.t(), t() | String.t()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.error()
      @spec delete(EdgePaymentClient.t(), t() | String.t(), Keyword.t()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.error()
      def delete(_, _, options \\ [])

      def delete(%EdgePaymentClient{} = client, %__MODULE__{id: id} = record, options),
        do: delete(client, id, options)

      def delete(%EdgePaymentClient{} = client, id, options)
          when is_binary(id) do
        client
        |> EdgePaymentClient.delete("#{@path}/#{id}", options)
        |> EdgePaymentClient.update_client_from_request(client)
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec from_payload(
          {:ok, map() | nil, EdgePaymentClient.t()}
          | EdgePaymentClient.error()
        ) ::
          {:ok, struct() | list(struct()) | nil, EdgePaymentClient.t()} | EdgePaymentClient.error()
  def from_payload(
        {:ok,
         %{
           "data" => entity
         } = payload, client}
      )
      when is_map(entity) do
    entity
    |> EdgePaymentClient.Entity.to_struct(payload["links"])
    |> (&{:ok, &1, client}).()
  end

  def from_payload(
        {:ok,
         %{
           "data" => entities
         }, client}
      )
      when is_list(entities) do
    entities
    |> Enum.map(&EdgePaymentClient.Entity.to_struct(&1, nil))
    |> (&{:ok, &1, client}).()
  end

  def from_payload({:ok, nil, client}), do: {:ok, nil, client}
  def from_payload({:error, _} = error), do: error
  def from_payload({:unprocessable_content, _exception, _response} = error), do: error
  def from_payload({:decoding_error, _exception, _response} = error), do: error

  @spec encode_relation({atom(), %{id: String.t(), type: String.t()}}) ::
          {atom(), map()}
  def encode_relation({relation_name, %{id: id, type: type}}) do
    {relation_name, %{"data" => %{"id" => id, "type" => type}}}
  end
end

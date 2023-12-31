defmodule EdgePaymentClient.Resource do
  @type result(entity_or_entities) ::
          {:ok, entity_or_entities, EdgePaymentClient.Resource.included(),
           EdgePaymentClient.Resource.links(), EdgePaymentClient.Resource.relationships()}
  @type error() ::
          {:unprocessable_content, map(), Finch.Response.t()}
          | {:error, Finch.Response.t() | Mint.TransportError.t() | %Protocol.UndefinedError{}}
          | {:decoding_error, Jason.DecodeError.t(), Finch.Response.t()}
  @type links() :: map() | nil
  @type relationships() :: map() | nil
  @type included() :: list(map()) | nil
  @spec with_list() :: tuple()
  defmacro with_list() do
    quote do
      @doc """
      Fetches all `#{Kernel.inspect(__MODULE__)}.t()`.

      The `query` argument can be:

        - `fields`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant_account"]
        - `sort`, ... i.e. `sort: ["-name"]
        - `filter`, ... i.e. `fields: %{name: "John"}`
      """
      @spec list(EdgePaymentClient.t(), Keyword.t() | nil) ::
              EdgePaymentClient.Resource.result(list(t())) | EdgePaymentClient.Resource.error()
      def list(client, query \\ [])
          when is_struct(client, EdgePaymentClient) do
        client
        |> EdgePaymentClient.get("#{@path}", query)
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec with_show() :: tuple()
  defmacro with_show() do
    quote do
      @doc """
      Fetches a `#{Kernel.inspect(__MODULE__)}.t()` by `record` or by `id`.

      The `query` argument can be:

        - `fields`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant_account"]
      """
      @spec show(EdgePaymentClient.t(), String.t() | t(), Keyword.t() | nil) ::
              EdgePaymentClient.Resource.result(t() | nil) | EdgePaymentClient.Resource.error()
      def show(_, _, query \\ [])

      def show(%EdgePaymentClient{} = client, %__MODULE__{id: id}, query),
        do: show(client, id, query)

      def show(%EdgePaymentClient{} = client, id, query) when is_binary(id) do
        client
        |> EdgePaymentClient.get("#{@path}/#{id}", query)
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec with_create() :: tuple()
  defmacro with_create() do
    quote do
      @spec create(EdgePaymentClient.t()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.Resource.error()
      @spec create(EdgePaymentClient.t(), map()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.Resource.error()
      @spec create(EdgePaymentClient.t(), map(), map()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.Resource.error()
      @spec create(EdgePaymentClient.t(), map(), map(), Keyword.t()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.Resource.error()
      def create(
            %EdgePaymentClient{} = client,
            attributes \\ %{},
            relationships \\ %{},
            query \\ []
          )
          when is_map(attributes) do
        client
        |> EdgePaymentClient.post(
          "#{@path}",
          %{
            data: %{type: @resource_type, attributes: attributes, relationships: relationships}
          },
          query
        )
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec with_update() :: tuple()
  defmacro with_update() do
    quote do
      @doc """
      Updates an existing `#{Kernel.inspect(__MODULE__)}.t()` with a new set of `attributes` and optionally `relationships`.

      The `query` argument can be:

        - `fields`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant_account"]
      """
      @spec update(EdgePaymentClient.t(), t() | String.t(), map()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.Resource.error()
      @spec update(EdgePaymentClient.t(), t() | String.t(), map(), map()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.Resource.error()
      @spec update(EdgePaymentClient.t(), t() | String.t(), map(), map(), Keyword.t()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.Resource.error()
      def update(
            _,
            _,
            attributes \\ %{},
            relationships \\ %{},
            query \\ []
          )

      def update(
            %EdgePaymentClient{} = client,
            %__MODULE__{id: id} = record,
            attributes,
            relationships,
            query
          )
          when is_map(attributes) do
        update(client, id, attributes, relationships, query)
      end

      def update(
            %EdgePaymentClient{} = client,
            id,
            attributes,
            relationships,
            query
          )
          when is_binary(id) and is_map(attributes) do
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
          query
        )
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec with_delete() :: tuple()
  defmacro with_delete() do
    quote do
      @spec delete(EdgePaymentClient.t(), t() | String.t()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.Resource.error()
      @spec delete(EdgePaymentClient.t(), t() | String.t(), Keyword.t()) ::
              EdgePaymentClient.Resource.result(t()) | EdgePaymentClient.Resource.error()
      def delete(_, _, query \\ [])

      def delete(%EdgePaymentClient{} = client, %__MODULE__{id: id} = record, query),
        do: delete(client, id, query)

      def delete(%EdgePaymentClient{} = client, id, query)
          when is_binary(id) do
        client
        |> EdgePaymentClient.delete("#{@path}/#{id}", query)
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec from_payload({:ok, map() | list(map()), Finch.Response.t()} | error()) ::
          {:ok, struct() | list(struct()), list() | nil, map() | nil, map() | nil} | error()
  def from_payload(
        {:ok,
         %{
           "data" => entity
         } = payload, _response}
      )
      when is_map(entity) do
    entity
    |> EdgePaymentClient.Entity.to_struct(payload["links"])
    |> EdgePaymentClient.Resource.to_result(
      payload["included"],
      payload["links"],
      payload["meta"]
    )
  end

  def from_payload(
        {:ok,
         %{
           "data" => entities
         } = payload, _response}
      )
      when is_list(entities) do
    entities
    |> Enum.map(&EdgePaymentClient.Entity.to_struct(&1, nil))
    |> EdgePaymentClient.Resource.to_result(
      payload["included"],
      payload["links"],
      payload["meta"]
    )
  end

  def from_payload({:error, _} = error), do: error
  def from_payload({:unprocessable_content, _} = error), do: error
  def from_payload({:decoding_error, _} = error), do: error

  @spec encode_relation({atom(), %{id: String.t(), type: String.t()}}) ::
          {atom(), map()}
  def encode_relation({relation_name, %{id: id, type: type}}) do
    {relation_name, %{"data" => %{"id" => id, "type" => type}}}
  end

  @spec to_result(struct() | list(struct()), list(map()) | nil, map(), map() | nil) ::
          {:ok, struct() | list(struct()), list(struct()), map(), map()}
  def to_result(entity_or_entities, nil, links, meta) do
    {:ok, entity_or_entities, [], links, meta}
  end

  def to_result(entity_or_entities, included, links, meta) do
    {:ok, entity_or_entities, Enum.map(included, &EdgePaymentClient.Entity.to_struct(&1, nil)),
     links, meta}
  end
end

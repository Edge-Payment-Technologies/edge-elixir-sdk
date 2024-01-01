defmodule EdgePaymentClient.Resource do
  # TODO: change to EdgePaymentClient.t()
  @type result(entity_or_entities) ::
          {:ok, entity_or_entities, map()}
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
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  @spec with_create() :: tuple()
  defmacro with_create() do
    quote location: :keep do
      @doc """
      Creates an new `#{Kernel.inspect(__MODULE__)}.t()` with `attributes: `#{Kernel.inspect(__MODULE__)}.attributes_for_create()` and `relationships:`.

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
                | EdgePaymentClient.query()
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
                | EdgePaymentClient.query()
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
        |> EdgePaymentClient.Resource.from_payload()
      end
    end
  end

  # TODO: replace map() in third arg with client
  @spec from_payload(
          {:ok, map() | list(map()) | nil, Finch.Response.t()}
          | EdgePaymentClient.error()
        ) ::
          {:ok, struct() | list(struct()), map()} | EdgePaymentClient.error()
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

  # TODO: return client here
  def from_payload({:ok, nil, _response}), do: {:ok, nil, %{}}
  def from_payload({:error, _} = error), do: error
  def from_payload({:unprocessable_content, _, _response} = error), do: error
  def from_payload({:decoding_error, _, _response} = error), do: error

  @spec encode_relation({atom(), %{id: String.t(), type: String.t()}}) ::
          {atom(), map()}
  def encode_relation({relation_name, %{id: id, type: type}}) do
    {relation_name, %{"data" => %{"id" => id, "type" => type}}}
  end

  # TODO: Replace third arg map with client
  @spec to_result(struct() | list(struct()), list(map()) | nil, map(), map() | nil) ::
          {:ok, struct() | list(struct()), map()}
  def to_result(entity_or_entities, nil, links, meta) do
    # [], links, meta
    {:ok, entity_or_entities, %{}}
  end

  def to_result(entity_or_entities, included, links, meta) do
    # Enum.map(included, &EdgePaymentClient.Entity.to_struct(&1, nil)),
    #  links, meta
    {:ok, entity_or_entities, %{}}
  end
end

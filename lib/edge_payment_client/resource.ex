defmodule EdgePaymentClient.Resource do
  @type error() ::
          {:unprocessable_content, map(), Finch.Response.t()}
          | {:error, Jason.DecodeError.t(), Finch.Response.t()}
          | {:error, Finch.Response.t() | Mint.TransportError.t()}
  @spec with_list() :: tuple()
  defmacro with_list() do
    quote do
      @spec list(EdgePaymentClient.t(), Keyword.t() | nil) ::
              list(t()) | EdgePaymentClient.Resource.error()
      def list(client, query \\ [])
          when is_struct(client, EdgePaymentClient) do
        client
        |> EdgePaymentClient.get("#{@path}", query)
        |> EdgePaymentClient.Resource.from_payload_with(&struct_from_entity/3)
      end
    end
  end

  @spec with_show() :: tuple()
  defmacro with_show() do
    quote do
      @spec show(EdgePaymentClient.t(), String.t() | t(), Keyword.t() | nil) ::
              t() | nil | EdgePaymentClient.Resource.error()
      def show(_, _, query \\ [])

      def show(%EdgePaymentClient{} = client, %__MODULE__{id: id}, query),
        do: show(client, id, query)

      def show(%EdgePaymentClient{} = client, id, query) when is_binary(id) do
        client
        |> EdgePaymentClient.get("#{@path}/#{id}", query)
        |> EdgePaymentClient.Resource.from_payload_with(&struct_from_entity/3)
      end
    end
  end

  @spec with_create() :: tuple()
  defmacro with_create() do
    quote do
      @spec create(EdgePaymentClient.t()) :: t() | EdgePaymentClient.Resource.error()
      @spec create(EdgePaymentClient.t(), map()) :: t() | EdgePaymentClient.Resource.error()
      @spec create(EdgePaymentClient.t(), map(), map()) ::
              t() | EdgePaymentClient.Resource.error()
      @spec create(EdgePaymentClient.t(), map(), map(), Keyword.t()) ::
              t() | EdgePaymentClient.Resource.error()
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
        |> EdgePaymentClient.Resource.from_payload_with(&struct_from_entity/3)
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
        - `include`, a list of relationship chains  for the response to return i.e. `include: ["#{@resource_type}.merchant_account"]
      """
      @spec update(EdgePaymentClient.t(), t() | String.t(), map()) ::
              t() | EdgePaymentClient.Resource.error()
      @spec update(EdgePaymentClient.t(), t() | String.t(), map(), map()) ::
              t() | EdgePaymentClient.Resource.error()
      @spec update(EdgePaymentClient.t(), t() | String.t(), map(), map(), Keyword.t()) ::
              t() | EdgePaymentClient.Resource.error()
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
                relationships |> Enum.map(&EdgePaymentClient.Resource.encode_relation/1)
            }
          },
          query
        )
        |> EdgePaymentClient.Resource.from_payload_with(&struct_from_entity/3)
      end
    end
  end

  @spec with_delete() :: tuple()
  defmacro with_delete() do
    quote do
      @spec delete(EdgePaymentClient.t(), t() | String.t()) ::
              t() | EdgePaymentClient.Resource.error()
      @spec delete(EdgePaymentClient.t(), t() | String.t(), Keyword.t()) ::
              t() | EdgePaymentClient.Resource.error()
      def delete(_, _, query \\ [])

      def delete(%EdgePaymentClient{} = client, %__MODULE__{id: id} = record, query),
        do: delete(client, id, query)

      def delete(%EdgePaymentClient{} = client, id, query)
          when is_binary(id) do
        client
        |> EdgePaymentClient.delete("#{@path}/#{id}", query)
        |> EdgePaymentClient.Resource.from_payload_with(&struct_from_entity/3)
      end
    end
  end

  @spec from_payload_with(
          {:ok, %{payload: map() | list(map()), response: Finch.Response.t()}} | error(),
          function()
        ) :: struct() | list(struct()) | error()
  def from_payload_with(
        {:ok,
         %{
           payload:
             %{
               "data" => entity
             } = payload
         }},
        mapper
      )
      when is_function(mapper, 3) and is_map(entity) do
    mapper.(entity, payload["included"], payload["meta"])
  end

  def from_payload_with(
        {:ok,
         %{
           payload:
             %{
               "data" => entities
             } = payload
         }},
        mapper
      )
      when is_function(mapper, 3) and is_list(entities) do
    Enum.map(entities, &mapper.(&1, payload["included"], payload["meta"]))
  end

  def from_payload_with(error, _), do: error

  @spec encode_relation({atom(), %{:id => String.t(), :type => String.t()}}) ::
          {atom(), map()}
  def encode_relation({relation_name, %{id: id, type: type}}) do
    {relation_name, %{"data" => %{"id" => id, "type" => type}}}
  end
end

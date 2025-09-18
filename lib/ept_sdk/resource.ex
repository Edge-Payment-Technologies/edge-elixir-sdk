defmodule EPTSDK.Resource do
  @moduledoc """
  The basic shape of all resource requests, sliced into various common actions against resources.
  """

  defmacro defresource() do
    quote do
      @enforce_keys [
        :id,
        :type,
        :__raw__,
        :__links__
      ]
      defstruct Map.keys(@fields) ++
                  Map.keys(@relationships) ++
                  [
                    :id,
                    :type,
                    :__raw__,
                    :__links__
                  ]

      defp apply_field({key, _details}, accumulated, attributes, _selected)
           when attributes == %{} do
        Map.put(accumulated, key, %EPTSDK.PropertyNotAvailable{name: key, reason: :undefined})
      end

      defp apply_field({key, {type, options}}, accumulated, attributes, selected) do
        Map.put(
          accumulated,
          key,
          attributes
          |> EPTSDK.Encoder.fetch_field(key, type, selected, options)
          |> EPTSDK.Encoder.cast(key, type, options)
        )
      end

      defp apply_field({key, type}, accumulated, attributes, selected) when is_atom(type) do
        Map.put(
          accumulated,
          key,
          attributes
          |> EPTSDK.Encoder.fetch_field(key, type, selected)
          |> EPTSDK.Encoder.cast(key, type)
        )
      end

      defp apply_relationship({key, _details}, accumulated, relationships, _includes)
           when relationships == %{} do
        Map.put(accumulated, key, %EPTSDK.RelationshipNotAvailable{name: key, reason: :undefined})
      end

      defp apply_relationship({key, kind}, accumulated, relationships, includes) do
        Map.put(
          accumulated,
          key,
          relationships
          |> EPTSDK.Encoder.fetch_relationship(key, includes)
          |> EPTSDK.Encoder.cast(key, kind)
        )
      end

      def new(id, type, record, links, client) do
        attributes = Map.get(record, "attributes", %{})
        relationships = Map.get(record, "relationships", %{})
        links = Map.get(record, "relationships", links)

        struct(
          __MODULE__,
          Map.merge(
            Enum.reduce(
              @relationships,
              Enum.reduce(
                @fields,
                %{},
                &apply_field(&1, &2, attributes, Map.get(client.fields, type, []))
              ),
              &apply_relationship(&1, &2, relationships, client.include)
            ),
            %{
              id: id,
              type: type,
              __links__: links,
              __raw__: record
            }
          )
        )
      end
    end
  end

  defmacro deflist() do
    quote location: :keep do
      @doc """
      Fetches all `%#{Kernel.inspect(__MODULE__)}{}`.

      The `options` argument can be:

        - `fields`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant"]`
        - `sort`, ... i.e. `sort: ["-name"]`
        - `filter`, ... i.e. `fields: %{name: "John"}`
      """

      def list(client, options \\ [])
          when is_struct(client, EPTSDK) do
        client
        |> EPTSDK.get("#{@path}", options)
        |> EPTSDK.update_client_from_request(client)
        |> EPTSDK.Resource.from_payload()
      end
    end
  end

  defmacro defshow() do
    quote location: :keep do
      @doc """
      Fetches a `%#{Kernel.inspect(__MODULE__)}{}` by `record` or by `id`.

      The `options` argument can be:

        - `fields`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant"]`
      """

      def show(_, _, options \\ [])

      def show(%EPTSDK{} = client, %__MODULE__{id: id}, options),
        do: show(client, id, options)

      def show(%EPTSDK{} = client, id, options) when is_binary(id) do
        client
        |> EPTSDK.get("#{@path}/#{id}", options)
        |> EPTSDK.update_client_from_request(client)
        |> EPTSDK.Resource.from_payload()
      end
    end
  end

  defmacro defcreate() do
    quote location: :keep do
      @doc """
      Creates an new `%#{Kernel.inspect(__MODULE__)}{}}` with `attributes:` and `relationships:`.

      The `options` argument can also have:

        - `fields:`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include:`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant"]`
      """
      def create(
            %EPTSDK{} = client,
            options \\ []
          )
          when is_list(options) do
        attributes = Keyword.get(options, :attributes, %{})
        relationships = Keyword.get(options, :relationships, %{})

        client
        |> EPTSDK.post(
          "#{@path}",
          %{
            data: %{
              type: @resource_type,
              attributes: attributes,
              relationships:
                relationships
                |> Enum.map(&EPTSDK.Resource.encode_relation/1)
                |> Map.new()
            }
          },
          options |> Keyword.drop([:attributes, :relationships])
        )
        |> EPTSDK.update_client_from_request(client)
        |> EPTSDK.Resource.from_payload()
      end
    end
  end

  defmacro defupdate() do
    quote location: :keep do
      @doc """
      Updates an existing `%#{Kernel.inspect(__MODULE__)}` with `attributes:` and `relationships:`.

      The `options` argument can also have:

        - `fields:`, a map of filds to return for each resource type i.e. `fields: %{#{@resource_type}: ["id"]}`
        - `include:`, a list of relationship chains for the response to return i.e. `include: ["#{@resource_type}.merchant"]`
      """
      def update(
            _,
            _,
            options \\ []
          )

      def update(
            %EPTSDK{} = client,
            %__MODULE__{id: id} = record,
            options
          )
          when is_list(options) do
        update(client, id, options)
      end

      def update(
            %EPTSDK{} = client,
            id,
            options
          )
          when is_binary(id) and is_list(options) do
        attributes = Keyword.get(options, :attributes, %{})
        relationships = Keyword.get(options, :relationships, %{})

        client
        |> EPTSDK.patch(
          "#{@path}/#{id}",
          %{
            data: %{
              id: id,
              type: @resource_type,
              attributes: attributes,
              relationships:
                relationships
                |> Enum.map(&EPTSDK.Resource.encode_relation/1)
                |> Map.new()
            }
          },
          options
        )
        |> EPTSDK.update_client_from_request(client)
        |> EPTSDK.Resource.from_payload()
      end
    end
  end

  defmacro defdelete() do
    quote location: :keep do
      def delete(_, _, options \\ [])

      def delete(%EPTSDK{} = client, %__MODULE__{id: id} = record, options),
        do: delete(client, id, options)

      def delete(%EPTSDK{} = client, id, options)
          when is_binary(id) do
        client
        |> EPTSDK.delete("#{@path}/#{id}", options)
        |> EPTSDK.update_client_from_request(client)
        |> EPTSDK.Resource.from_payload()
      end
    end
  end

  @spec from_payload(
          {:ok, list(map()) | map() | nil, EPTSDK.t()}
          | {:error, any()}
          | {:error, :internal_server_error, :decoding_error, :unprocessable_content, any(),
             any()}
        ) ::
          {:ok, list(struct()) | struct() | nil, list(), EPTSDK.t()}
          | {:error, any()}
          | {:error, :internal_server_error, :decoding_error, :unprocessable_content, any(),
             Req.Response.t()}
  def from_payload(
        {:ok,
         %{
           "data" => entity
         } = payload, client}
      )
      when is_map(entity) do
    entity
    |> EPTSDK.Encoder.to_struct(payload["links"], client)
    |> (&{:ok, &1, payload["included"] || [], client}).()
  end

  def from_payload(
        {:ok,
         %{
           "data" => entities
         } = payload, client}
      )
      when is_list(entities) do
    entities
    |> Enum.map(&EPTSDK.Encoder.to_struct(&1, %{}, client))
    |> (&{:ok, &1, payload["included"] || [], client}).()
  end

  def from_payload({:ok, nil, client}), do: {:ok, nil, [], client}

  def from_payload({signal, _exception, response} = error)
      when signal in [:error, :internal_server_error, :decoding_error, :unprocessable_content] and
             is_struct(response, Req.Response),
      do: error

  def from_payload({:error, _exception} = error), do: error

  def encode_relation({relation_name, %{id: id, type: type}}) do
    {relation_name, %{"data" => %{"id" => id, "type" => type}}}
  end
end

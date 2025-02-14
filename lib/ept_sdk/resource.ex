defmodule EPTSDK.Resource do
  @moduledoc """
  The basic shape of all resource requests, sliced into various common actions against resources.
  """

  defmacro with_list() do
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

  defmacro with_show() do
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

  defmacro with_create() do
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

  defmacro with_update() do
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

  defmacro with_delete() do
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

  def from_payload(
        {:ok,
         %{
           "data" => entity
         } = payload, client}
      )
      when is_map(entity) do
    entity
    |> EPTSDK.Encoder.to_struct(payload["links"])
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
    |> Enum.map(&EPTSDK.Encoder.to_struct(&1, %{}))
    |> (&{:ok, &1, client}).()
  end

  def from_payload({:ok, nil, client}), do: {:ok, nil, client}
  def from_payload({:error, _} = error), do: error
  def from_payload({:unprocessable_content, _exception, _response} = error), do: error
  def from_payload({:decoding_error, _exception, _response} = error), do: error

  def encode_relation({relation_name, %{id: id, type: type}}) do
    {relation_name, %{"data" => %{"id" => id, "type" => type}}}
  end
end

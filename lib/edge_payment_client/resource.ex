defmodule EdgePaymentClient.Resource do
  defmacro with_list() do
    quote do
      @spec list(EdgePaymentClient.t(), Keyword.t() | nil) :: list(t()) | {:error, any()}
      def list(client, query \\ [])
          when is_struct(client, EdgePaymentClient) do
        client
        |> EdgePaymentClient.get("#{@path}", query)
        |> case do
          {:ok,
           %{
             json:
               %{
                 "data" => entities
               } = payload
           }} ->
            Enum.map(entities, &struct_from_entity(&1, payload["included"], payload["meta"]))

          error ->
            error
        end
      end
    end
  end

  defmacro with_show() do
    quote do
      @spec show(EdgePaymentClient.t(), String.t() | t(), Keyword.t() | nil) :: t() | nil | {:error, any()}
      def show(_client, _identifier, _query \\ [])
      def show(%EdgePaymentClient{} = client, %{id: id}, query) when is_binary(id), do: show(client, id, query)
      def show(%EdgePaymentClient{} = client, id, query) when is_binary(id) do
        client
        |> EdgePaymentClient.get("#{@path}/#{id}")
        |> case do
          {:ok,
          %{
            json:
              %{
                "data" => entity
              } = payload
          }} ->
            struct_from_entity(entity, payload["included"], payload["meta"])

          error ->
            error
        end
      end
    end
  end

  defmacro with_create() do
    quote do
      @spec create(EdgePaymentClient.t()) :: t() | {:error, any()}
      @spec create(EdgePaymentClient.t(), map()) :: t() | {:error, any()}
      @spec create(EdgePaymentClient.t(), map(), map()) :: t() | {:error, any()}
      @spec create(EdgePaymentClient.t(), map(), map(), Keyword.t()) :: t() | {:error, any()}
      def create(client, attributes \\ %{}, relationships \\ %{}, query \\ [])
          when is_struct(client, EdgePaymentClient) and is_map(attributes) do
        client
        |> EdgePaymentClient.post("#{@path}", %{data: %{type: @resource_type, attributes: attributes}})
        |> case do
          {:ok,
          %{
            json:
              %{
                "data" => entity
              } = payload
          }} ->
            struct_from_entity(entity, payload["included"], payload["meta"])

          error ->
            error
        end
      end
    end
  end
end

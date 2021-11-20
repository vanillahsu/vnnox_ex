defmodule VNNOX.Api do
  @moduledoc false

  defmacro __using__(opts) do
    quote do
      alias VNNOX.Parser
      import VNNOX.Utils

      def build_url(path, params) do
        "#{base_url()}#{path}?#{query_string(params)}"
      end

      def do_get(path, params) when is_map(params) do
        do_request(:get, path, params, "")
      end

      def do_get(path, params) when is_list(params) do
        do_get(path, Enum.into(params, %{}))
      end

      def do_post(path, body \\ %{})

      def do_post(path, body) when is_list(body) do
        do_post(path, Enum.into(body, %{}))
      end

      def do_post(path, body) do
        do_request(:post, path, %{}, Jason.encode!(body))
      end

      def do_put(path, body \\ %{}) do
        do_request(:put, path, %{}, Jason.encode!(body))
      end

      def do_patch(path, body \\ %{})

      def do_patch(path, body) when is_list(body) do
        do_patch(path, Enum.into(body, %{}))
      end

      def do_patch(path, body) do
        do_request(:patch, path, %{}, Jason.encode!(body))
      end

      def do_delete(path) do
        do_request(:delete, path)
      end

      def do_delete(path, params) do
        do_request(:delete, path, params)
      end

      defp do_request(method, path, params \\ %{}, req_body \\ "") do
        uri = build_url(path, params)

        method
        |> HTTPoison.request(uri, req_body, req_header(unquote(opts)[:token]), http_opts())
        |> Parser.parse()
      end

      defp query_string(params) do
        default_params()
        |> Map.merge(params)
        |> URI.encode_query()
      end

      defp default_params do
        %{}
      end

      defoverridable default_params: 0
    end
  end
end

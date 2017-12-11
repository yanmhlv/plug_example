defmodule PlugExample.Plug.VerifyRequest do
    defmodule IncompleteRequestError do
        defexception message: "", plug_status: 400
    end

    def init(opts), do: opts

    def call(%Plug.Conn{request_path: path} = conn, opts) do
        if path in opts[:paths], do: verify_request!(conn.body_params, opts[:fields])
        conn
    end

    defp verify_request!(body_params, fields) do
        verified =
          body_params
          |> Map.keys()
          |> contains_fields?(fields)

        unless verified, do: raise(IncompleteRequestError)
      end

      defp contains_fields?(keys, fields), do: Enum.all?(fields, &(&1 in keys))
end

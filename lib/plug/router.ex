defmodule PlugExample.Router do
    use Plug.Router

    alias PlugExample.Plug.VerifyRequest

    plug(Plug.Parsers, parsers: [:urlencoded, :multipart])

    plug(
        VerifyRequest,
        fields: ["content", "mimetype"],
        paths: ["/upload"],
    )

    plug(:match)
    plug(:dispatch)

    get("/", do: send_resp(conn, 200, "Welcome"))
    post("/upload", do: send_resp(conn, 201, "uploaded"))
    match(_, do: send_resp(conn, 404, "Oops!"))
  end

defmodule Mini.Router do
  use Plug.Router

  plug(Plug.RequestId)
  plug(Plug.Logger, log: :info)
  plug(:match)
  plug(:dispatch)

  get "/version" do
    {:ok, version} = :application.get_key(:mini, :vsn)
    send_resp(conn, 200, version)
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end

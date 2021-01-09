defmodule MinimalServer.Endpoint do
  @moduledoc """
  A plug responsible for lkogging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  use Plug.Router

  # This module is a Plug, that also implements it's own plug pipeline, below:

  # Using Plug.Logger for logging request information
  plug(Plug.Logger)
  # responsible for matching routes
  plug(:match)

  # Using Poison for JSON decoding
  # Note, order of plugs is important, by placing this _after_ the 'match' plug,
  # we will only parse the request AFTER there is a route match.
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  # responsible for dispatching responses
  plug(:dispatch)

  # A Simple route to test that the server is up
  # Note, all routes must return a connection as per the Plug spec.
  get "/ping" do
    send_resp(conn, 200, "pong!")
  end
end

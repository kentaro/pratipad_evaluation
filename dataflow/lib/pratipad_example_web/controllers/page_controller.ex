defmodule PratipadExampleWeb.PageController do
  use PratipadExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

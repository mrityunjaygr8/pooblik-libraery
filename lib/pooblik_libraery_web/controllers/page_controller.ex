defmodule PooblikLibraeryWeb.PageController do
  use PooblikLibraeryWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end

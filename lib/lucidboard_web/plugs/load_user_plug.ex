defmodule LucidboardWeb.LoadUserPlug do
  @moduledoc "Load the User struct (or `nil`) into conn.assigns."
  import Plug.Conn
  import Ecto.Query
  alias Lucidboard.{Repo, User}

  def init(opts), do: opts

  def call(conn, _opts) do
    user = Repo.one(from(User, limit: 1))
    assign(conn, :user, user)
  end
end

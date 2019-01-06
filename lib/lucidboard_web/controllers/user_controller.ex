defmodule LucidboardWeb.UserController do
  use LucidboardWeb, :controller

  def signin(conn, _params) do
    render(conn, "signin.html")
  end

  def signout(conn, _params) do
    conn
    |> put_flash(:info, "You have been signout out.")
    |> put_status(:see_other)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def settings(conn, _params) do
    case conn.assigns[:user] do
      nil ->
        {:see_other, Routes.user_path(conn, :signin)}

      user ->
        render(conn, "settings.html", user: user)
    end
  end
end

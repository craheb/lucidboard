defmodule LucidboardWeb.UserController do
  use LucidboardWeb, :controller
  alias Lucidboard.{Repo, User}

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
    themes = ["Red", "Blue", "Green"]
    render(conn, "settings.html", user: conn.assigns[:user], themes: themes)
  end

  def update_settings(conn, params) do
    with %{valid?: true} = cs <- User.changeset(conn.assigns[:user], params),
         {:ok, new_user} <- Repo.update(cs) do
      conn
      |> assign(:user, new_user)
      |> put_flash(:info, "Your settings have been saved.")
      |> put_status(:see_other)
      |> redirect(to: Routes.user_path(conn, :settings))
    end
  end
end

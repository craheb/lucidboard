defmodule LucidboardWeb.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """
  use LucidboardWeb, :controller
  alias Lucidboard.Account
  alias LucidboardWeb.DashboardLive
  alias LucidboardWeb.BoardLive
  alias LucidboardWeb.Router.Helpers, as: Routes
  alias Ueberauth.Strategy.Helpers

  plug(Ueberauth)

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn), callback_params: %{"board_id" => "1"})
  end

  def dumb_signin(conn, %{
        "signin" => %{"username" => username},
        "board_id" => board_id
      }) do
    if Lucidboard.auth_provider() != :dumb do
      {:error, :not_found}
    else
      redirect_path = get_redirect_path(conn, board_id)

      case Account.by_username(username) do
        nil ->
          {:ok, user} =
            Account.create(name: username, full_name: "Mister #{username}")

          conn
          |> put_session(:user_id, user.id)
          |> put_flash(:info, """
          We've created your account and you're now signed in!
          """)
          |> redirect(to: redirect_path)

        user ->
          conn
          |> put_session(:user_id, user.id)
          |> put_flash(:info, "You have successfully signed in!")
          |> redirect(to: redirect_path)
      end
    end
  end

  def signout(conn, _params) do
    conn
    |> put_flash(:info, "You have been signed out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{
    "board_id" => board_id
  }) do
    case Account.auth_to_user(auth) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Hello, #{user.name}!")
        |> redirect(to: get_redirect_path(conn, board_id))

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  defp get_redirect_path(conn, board_id) do
    if is_nil(board_id),
      do: Routes.live_path(conn, DashboardLive),
      else: Routes.live_path(conn, BoardLive, board_id)
  end
end

defmodule LucidboardWeb.ViewHelper do
  @moduledoc "Helper functions for all views"
  import Phoenix.HTML, only: [raw: 1]

  @doc "Create a font-awesome icon by name"
  def fa(name) do
    raw(~s|<i class="fas fa-#{name}"></i>|)
  end
end

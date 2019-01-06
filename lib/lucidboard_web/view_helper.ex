defmodule LucidboardWeb.ViewHelper do
  @moduledoc "Helper functions for all views"
  import Phoenix.HTML, only: [raw: 1]

  @doc "Create a font-awesome icon by name"
  def fa(name, class \\ nil) do
    class = Enum.join(["icon", class], " ")

    """
    <span class="#{class}">
      <i class="fas fa-#{name}"></i>
    </span>
    """
    |> raw()
  end

  def show_card_count(column) do
    count =
      Enum.reduce(column.piles, 0, fn pile, acc ->
        acc + length(pile.cards)
      end)

    "#{count} card" <> if count == 1, do: "", else: "s"
  end
end

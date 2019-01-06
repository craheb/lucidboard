defmodule LucidboardWeb.ViewHelper do
  @moduledoc "Helper functions for all views"
  import Phoenix.HTML, only: [raw: 1]

  @doc "Create a font-awesome icon by name"
  def fas(name, class \\ []), do: fa("fas", name, class)

  def fab(name, class \\ []), do: fa("fab", name, class)

  def show_card_count(column) do
    count = Enum.reduce(column.piles, 0, fn pile, acc ->
        acc + length(pile.cards)
      end)

    "#{count} card" <> if count == 1, do: "", else: "s"
  end

  def card_body_size_by_copy(body) do
    chars = String.length(body)

    cond do
      chars < 20 -> "3"
      chars < 50 -> "4"
      true -> "5"
    end
  end

  defp fa(family, name, class) when is_binary(class) do
    fa(family, name, [class])
  end

  defp fa(family, name, class) do
    class =
      Enum.join(["icon"] ++ class, " ")

    """
    <span class="#{class}">
      <i class="#{family} fa-#{name}"></i>
    </span>
    """
    |> raw()
  end
end

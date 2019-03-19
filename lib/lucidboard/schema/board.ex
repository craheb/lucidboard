defimpl Inspect, for: Lucidboard.Board do
  import Inspect.Algebra

  def inspect(_dict, _opts) do
    concat(["#board<>"])
  end
end

defmodule Lucidboard.Board do
  @moduledoc "Schema for a board record"
  use Ecto.Schema
  import Ecto.Changeset
  alias Lucidboard.{BoardSettings, Column, User}

  schema "boards" do
    field(:title, :string)
    embeds_one(:settings, BoardSettings)
    has_many(:columns, Column)
    belongs_to(:user, User)

    timestamps()
  end

  @spec new(keyword) :: Board.t()
  def new(fields \\ []) do
    defaults = [settings: BoardSettings.new()]
    struct(__MODULE__, Keyword.merge(defaults, fields))
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title])
    |> cast_assoc(:columns)
    |> validate_required([:title])
  end
end

defmodule BookShop.Schema do
  @moduledoc """
  """

  defmacro __using__(_opts) do
    quote do
      # uses
      use Ecto.Schema

      # imports
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      # requires
      require IEx

      @type t :: %__MODULE__{}
    end
  end
end

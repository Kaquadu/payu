defmodule BookShop.Repo.Migrations.CreateShopStatuses do
  use Ecto.Migration

  def change do
    create table(:shop_statuses) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:shop_statuses, :name)

    alter table(:books) do
      add :shop_status_id, references(:shop_statuses)
    end
  end
end

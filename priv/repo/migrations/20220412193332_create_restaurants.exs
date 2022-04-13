defmodule Melp.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add :code, :text
      add :rating, :integer
      add :name, :text
      add :site, :text
      add :email, :text
      add :phone, :text
      add :street, :text
      add :city, :text
      add :state, :text
      add :lat, :float
      add :lng, :float
      add :geom, :geometry
    end
  end
end

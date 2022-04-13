defmodule Melp.Apimelp.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "restaurants" do
    field :city, :string
    field :code, :string
    field :email, :string
    field :lat, :float
    field :lng, :float
    field :name, :string
    field :phone, :string
    field :rating, :integer
    field :site, :string
    field :state, :string
    field :street, :string

  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:code, :rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng])
    |> validate_required([:code, :rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng])
  end
end

defmodule Melp.ApimelpFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Melp.Apimelp` context.
  """

  @doc """
  Generate a restaurant.
  """
  def restaurant_fixture(attrs \\ %{}) do
    {:ok, restaurant} =
      attrs
      |> Enum.into(%{
        city: "some city",
        code: "some code",
        email: "some email",
        lat: 120.5,
        lng: 120.5,
        name: "some name",
        phone: "some phone",
        rating: 42,
        site: "some site",
        state: "some state",
        street: "some street"
      })
      |> Melp.Apimelp.create_restaurant()

    restaurant
  end
end

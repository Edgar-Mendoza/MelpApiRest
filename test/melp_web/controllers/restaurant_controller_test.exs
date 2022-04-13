defmodule MelpWeb.RestaurantControllerTest do
  use MelpWeb.ConnCase

  import Melp.ApimelpFixtures

  @create_attrs %{city: "some city", code: "some code", email: "some email", lat: 120.5, lng: 120.5, name: "some name", phone: "some phone", rating: 42, site: "some site", state: "some state", street: "some street"}
  @update_attrs %{city: "some updated city", code: "some updated code", email: "some updated email", lat: 456.7, lng: 456.7, name: "some updated name", phone: "some updated phone", rating: 43, site: "some updated site", state: "some updated state", street: "some updated street"}
  @invalid_attrs %{city: nil, code: nil, email: nil, lat: nil, lng: nil, name: nil, phone: nil, rating: nil, site: nil, state: nil, street: nil}

  describe "index" do
    test "lists all restaurants", %{conn: conn} do
      conn = get(conn, Routes.restaurant_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Restaurants"
    end
  end

  describe "new restaurant" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.restaurant_path(conn, :new))
      assert html_response(conn, 200) =~ "New Restaurant"
    end
  end

  describe "create restaurant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.restaurant_path(conn, :create), restaurant: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.restaurant_path(conn, :show, id)

      conn = get(conn, Routes.restaurant_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Restaurant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.restaurant_path(conn, :create), restaurant: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Restaurant"
    end
  end

  describe "edit restaurant" do
    setup [:create_restaurant]

    test "renders form for editing chosen restaurant", %{conn: conn, restaurant: restaurant} do
      conn = get(conn, Routes.restaurant_path(conn, :edit, restaurant))
      assert html_response(conn, 200) =~ "Edit Restaurant"
    end
  end

  describe "update restaurant" do
    setup [:create_restaurant]

    test "redirects when data is valid", %{conn: conn, restaurant: restaurant} do
      conn = put(conn, Routes.restaurant_path(conn, :update, restaurant), restaurant: @update_attrs)
      assert redirected_to(conn) == Routes.restaurant_path(conn, :show, restaurant)

      conn = get(conn, Routes.restaurant_path(conn, :show, restaurant))
      assert html_response(conn, 200) =~ "some updated city"
    end

    test "renders errors when data is invalid", %{conn: conn, restaurant: restaurant} do
      conn = put(conn, Routes.restaurant_path(conn, :update, restaurant), restaurant: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Restaurant"
    end
  end

  describe "delete restaurant" do
    setup [:create_restaurant]

    test "deletes chosen restaurant", %{conn: conn, restaurant: restaurant} do
      conn = delete(conn, Routes.restaurant_path(conn, :delete, restaurant))
      assert redirected_to(conn) == Routes.restaurant_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.restaurant_path(conn, :show, restaurant))
      end
    end
  end

  defp create_restaurant(_) do
    restaurant = restaurant_fixture()
    %{restaurant: restaurant}
  end
end

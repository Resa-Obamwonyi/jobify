defmodule JobifyWeb.IndustryControllerTest do
  use JobifyWeb.ConnCase

  import Jobify.JobsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all industries", %{conn: conn} do
      conn = get(conn, ~p"/industries")
      assert html_response(conn, 200) =~ "Listing Industries"
    end
  end

  describe "new industry" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/industries/new")
      assert html_response(conn, 200) =~ "New Industry"
    end
  end

  describe "create industry" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/industries", industry: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/industries/#{id}"

      conn = get(conn, ~p"/industries/#{id}")
      assert html_response(conn, 200) =~ "Industry #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/industries", industry: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Industry"
    end
  end

  describe "edit industry" do
    setup [:create_industry]

    test "renders form for editing chosen industry", %{conn: conn, industry: industry} do
      conn = get(conn, ~p"/industries/#{industry}/edit")
      assert html_response(conn, 200) =~ "Edit Industry"
    end
  end

  describe "update industry" do
    setup [:create_industry]

    test "redirects when data is valid", %{conn: conn, industry: industry} do
      conn = put(conn, ~p"/industries/#{industry}", industry: @update_attrs)
      assert redirected_to(conn) == ~p"/industries/#{industry}"

      conn = get(conn, ~p"/industries/#{industry}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, industry: industry} do
      conn = put(conn, ~p"/industries/#{industry}", industry: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Industry"
    end
  end

  describe "delete industry" do
    setup [:create_industry]

    test "deletes chosen industry", %{conn: conn, industry: industry} do
      conn = delete(conn, ~p"/industries/#{industry}")
      assert redirected_to(conn) == ~p"/industries"

      assert_error_sent 404, fn ->
        get(conn, ~p"/industries/#{industry}")
      end
    end
  end

  defp create_industry(_) do
    industry = industry_fixture()
    %{industry: industry}
  end
end

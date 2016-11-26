defmodule ExShopify.ApplicationCharge do
  @moduledoc """
  A one-time charge to a shop.
  """

  import ExShopify.API
  import ExShopify.Resource

  @type application_charge_resource :: {:ok, %ExShopify.ApplicationCharge{}, %ExShopify.Meta{}}

  defstruct [:confirmation_url, :created_at, :id, :name, :price, :return_url,
             :status, :test, :updated_at]

  @doc """
  Activate a previously accepted one-time application charge.
  """
  @spec activate(%ExShopify.Session{}, integer | String.t, map) :: application_charge_resource | ExShopify.Resource.error
  def activate(session \\ nil, id, params) do
    request(:post, "/application_charges/#{id}/activate.json", params, session)
    |> serialize_resource(&serialize_single/1)
  end

  @doc """
  Create a new one-time application charge.
  """
  @spec create(%ExShopify.Session{}, map) :: application_charge_resource | ExShopify.Resource.error
  def create(session \\ nil, params) do
    request(:post, "/application_charges.json", params, session)
    |> serialize_resource(&serialize_single/1)
  end

  @doc """
  Retrieve one-time application charge.
  """
  @spec find(%ExShopify.Session{}, integer | String.t, map) :: application_charge_resource | ExShopify.Resource.error
  def find(session \\ nil, id, params \\ %{}) do
    request(:get, "/application_charges/#{id}.json", params, session)
    |> serialize_resource(&serialize_single/1)
  end

  @doc """
  All charges that have been requested are retrieved by this request.
  """
  @spec list(%ExShopify.Session{}, map) :: [application_charge_resource] | ExShopify.Resource.error
  def list(session \\ nil, params \\ %{}) do
    request(:get, "/application_charges.json", params, session)
    |> serialize_resource(&serialize_multi/1)
  end

  @doc false
  def response_mapping do
    %ExShopify.ApplicationCharge{}
  end

  # private

  defp serialize_single(body) do
    Poison.decode!(body, as: %{"application_charge" => response_mapping})["application_charge"]
  end

  defp serialize_multi(body) do
    Poison.decode!(body, as: %{"application_charges" => [response_mapping]})["application_charges"]
  end
end

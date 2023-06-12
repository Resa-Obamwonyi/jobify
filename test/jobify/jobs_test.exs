defmodule Jobify.JobsTest do
  use Jobify.DataCase

  alias Jobify.Jobs

  describe "jobs" do
    alias Jobify.Jobs.Job

    import Jobify.JobsFixtures

    @invalid_attrs %{country: nil, description: nil, published: nil, title: nil}

    test "list_jobs/0 returns all jobs" do
      job = job_fixture()
      assert Jobs.list_jobs() == [job]
    end

    test "get_job!/1 returns the job with given id" do
      job = job_fixture()
      assert Jobs.get_job!(job.id) == job
    end

    test "create_job/1 with valid data creates a job" do
      valid_attrs = %{country: "some country", description: "some description", published: true, title: "some title"}

      assert {:ok, %Job{} = job} = Jobs.create_job(valid_attrs)
      assert job.country == "some country"
      assert job.description == "some description"
      assert job.published == true
      assert job.title == "some title"
    end

    test "create_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_job(@invalid_attrs)
    end

    test "update_job/2 with valid data updates the job" do
      job = job_fixture()
      update_attrs = %{country: "some updated country", description: "some updated description", published: false, title: "some updated title"}

      assert {:ok, %Job{} = job} = Jobs.update_job(job, update_attrs)
      assert job.country == "some updated country"
      assert job.description == "some updated description"
      assert job.published == false
      assert job.title == "some updated title"
    end

    test "update_job/2 with invalid data returns error changeset" do
      job = job_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_job(job, @invalid_attrs)
      assert job == Jobs.get_job!(job.id)
    end

    test "delete_job/1 deletes the job" do
      job = job_fixture()
      assert {:ok, %Job{}} = Jobs.delete_job(job)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_job!(job.id) end
    end

    test "change_job/1 returns a job changeset" do
      job = job_fixture()
      assert %Ecto.Changeset{} = Jobs.change_job(job)
    end
  end

  describe "industries" do
    alias Jobify.Jobs.Industry

    import Jobify.JobsFixtures

    @invalid_attrs %{name: nil}

    test "list_industries/0 returns all industries" do
      industry = industry_fixture()
      assert Jobs.list_industries() == [industry]
    end

    test "get_industry!/1 returns the industry with given id" do
      industry = industry_fixture()
      assert Jobs.get_industry!(industry.id) == industry
    end

    test "create_industry/1 with valid data creates a industry" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Industry{} = industry} = Jobs.create_industry(valid_attrs)
      assert industry.name == "some name"
    end

    test "create_industry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_industry(@invalid_attrs)
    end

    test "update_industry/2 with valid data updates the industry" do
      industry = industry_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Industry{} = industry} = Jobs.update_industry(industry, update_attrs)
      assert industry.name == "some updated name"
    end

    test "update_industry/2 with invalid data returns error changeset" do
      industry = industry_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_industry(industry, @invalid_attrs)
      assert industry == Jobs.get_industry!(industry.id)
    end

    test "delete_industry/1 deletes the industry" do
      industry = industry_fixture()
      assert {:ok, %Industry{}} = Jobs.delete_industry(industry)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_industry!(industry.id) end
    end

    test "change_industry/1 returns a industry changeset" do
      industry = industry_fixture()
      assert %Ecto.Changeset{} = Jobs.change_industry(industry)
    end
  end
end

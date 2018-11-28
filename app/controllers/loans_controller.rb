class LoansController < ApplicationController
  before_action :current_user_must_be_loan_user, :only => [:edit_form, :update_row, :destroy_row]

  def current_user_must_be_loan_user
    loan = Loan.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == loan.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @loans = current_user.loans.page(params[:page]).per(10)

    render("loan_templates/index.html.erb")
  end

  def show
    @pmt_adjustment = PmtAdjustment.new
    @loan = Loan.find(params.fetch("id_to_display"))

    render("loan_templates/show.html.erb")
  end

  def new_form
    @loan = Loan.new

    render("loan_templates/new_form.html.erb")
  end

  def create_row
    @loan = Loan.new

    @loan.current_balance = params.fetch("current_balance")
    @loan.original_amount = params.fetch("original_amount")
    @loan.interest_rate = params.fetch("interest_rate")
    @loan.periods_in_year = params.fetch("periods_in_year")
    @loan.user_id = params.fetch("user_id")

    if @loan.valid?
      @loan.save

      redirect_back(:fallback_location => "/loans", :notice => "Loan created successfully.")
    else
      render("loan_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @loan = Loan.find(params.fetch("prefill_with_id"))

    render("loan_templates/edit_form.html.erb")
  end

  def update_row
    @loan = Loan.find(params.fetch("id_to_modify"))

    @loan.current_balance = params.fetch("current_balance")
    @loan.original_amount = params.fetch("original_amount")
    @loan.interest_rate = params.fetch("interest_rate")
    @loan.periods_in_year = params.fetch("periods_in_year")
    

    if @loan.valid?
      @loan.save

      redirect_to("/loans/#{@loan.id}", :notice => "Loan updated successfully.")
    else
      render("loan_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_user
    @loan = Loan.find(params.fetch("id_to_remove"))

    @loan.destroy

    redirect_to("/users/#{@loan.user_id}", notice: "Loan deleted successfully.")
  end

  def destroy_row
    @loan = Loan.find(params.fetch("id_to_remove"))

    @loan.destroy

    redirect_to("/loans", :notice => "Loan deleted successfully.")
  end
end

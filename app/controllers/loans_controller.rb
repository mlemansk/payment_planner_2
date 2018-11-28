class LoansController < ApplicationController
  def index
    @loans = Loan.all

    render("loan_templates/index.html.erb")
  end

  def show
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
    @loan.user_id = params.fetch("user_id")

    if @loan.valid?
      @loan.save

      redirect_to("/loans/#{@loan.id}", :notice => "Loan updated successfully.")
    else
      render("loan_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row
    @loan = Loan.find(params.fetch("id_to_remove"))

    @loan.destroy

    redirect_to("/loans", :notice => "Loan deleted successfully.")
  end
end

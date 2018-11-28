class PmtAdjustmentsController < ApplicationController
  before_action :current_user_must_be_pmt_adjustment_user, :only => [:show, :edit_form, :update_row, :destroy_row]

  def current_user_must_be_pmt_adjustment_user
    pmt_adjustment = PmtAdjustment.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == pmt_adjustment.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @pmt_adjustments = current_user.pmt_adjustments.page(params[:page]).per(10)

    render("pmt_adjustment_templates/index.html.erb")
  end

  def show
    @pmt_adjustment = PmtAdjustment.find(params.fetch("id_to_display"))

    render("pmt_adjustment_templates/show.html.erb")
  end

  def new_form
    @pmt_adjustment = PmtAdjustment.new

    render("pmt_adjustment_templates/new_form.html.erb")
  end

  def create_row
    @pmt_adjustment = PmtAdjustment.new

    @pmt_adjustment.payment_occurence = params.fetch("payment_occurence")
    @pmt_adjustment.loan_id = params.fetch("loan_id")
    @pmt_adjustment.user_id = params.fetch("user_id")
    @pmt_adjustment.pmt_adjustment = params.fetch("pmt_adjustment")
    @pmt_adjustment.beg_pay_adj = params.fetch("beg_pay_adj")
    @pmt_adjustment.end_pay_adj = params.fetch("end_pay_adj")

    if @pmt_adjustment.valid?
      @pmt_adjustment.save

      redirect_back(:fallback_location => "/pmt_adjustments", :notice => "Pmt adjustment created successfully.")
    else
      render("pmt_adjustment_templates/new_form_with_errors.html.erb")
    end
  end

  def create_row_from_loan
    @pmt_adjustment = PmtAdjustment.new

    @pmt_adjustment.payment_occurence = params.fetch("payment_occurence")
    @pmt_adjustment.loan_id = params.fetch("loan_id")
    @pmt_adjustment.user_id = params.fetch("user_id")
    @pmt_adjustment.pmt_adjustment = params.fetch("pmt_adjustment")
    @pmt_adjustment.beg_pay_adj = params.fetch("beg_pay_adj")
    @pmt_adjustment.end_pay_adj = params.fetch("end_pay_adj")

    if @pmt_adjustment.valid?
      @pmt_adjustment.save

      redirect_to("/loans/#{@pmt_adjustment.loan_id}", notice: "PmtAdjustment created successfully.")
    else
      render("pmt_adjustment_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @pmt_adjustment = PmtAdjustment.find(params.fetch("prefill_with_id"))

    render("pmt_adjustment_templates/edit_form.html.erb")
  end

  def update_row
    @pmt_adjustment = PmtAdjustment.find(params.fetch("id_to_modify"))

    @pmt_adjustment.payment_occurence = params.fetch("payment_occurence")
    @pmt_adjustment.loan_id = params.fetch("loan_id")
    
    @pmt_adjustment.pmt_adjustment = params.fetch("pmt_adjustment")
    @pmt_adjustment.beg_pay_adj = params.fetch("beg_pay_adj")
    @pmt_adjustment.end_pay_adj = params.fetch("end_pay_adj")

    if @pmt_adjustment.valid?
      @pmt_adjustment.save

      redirect_to("/pmt_adjustments/#{@pmt_adjustment.id}", :notice => "Pmt adjustment updated successfully.")
    else
      render("pmt_adjustment_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_loan
    @pmt_adjustment = PmtAdjustment.find(params.fetch("id_to_remove"))

    @pmt_adjustment.destroy

    redirect_to("/loans/#{@pmt_adjustment.loan_id}", notice: "PmtAdjustment deleted successfully.")
  end

  def destroy_row_from_user
    @pmt_adjustment = PmtAdjustment.find(params.fetch("id_to_remove"))

    @pmt_adjustment.destroy

    redirect_to("/users/#{@pmt_adjustment.user_id}", notice: "PmtAdjustment deleted successfully.")
  end

  def destroy_row
    @pmt_adjustment = PmtAdjustment.find(params.fetch("id_to_remove"))

    @pmt_adjustment.destroy

    redirect_to("/pmt_adjustments", :notice => "Pmt adjustment deleted successfully.")
  end
end

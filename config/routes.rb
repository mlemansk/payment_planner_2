Rails.application.routes.draw do
  # Routes for the Loan resource:

  # CREATE
  get("/loans/new", { :controller => "loans", :action => "new_form" })
  post("/create_loan", { :controller => "loans", :action => "create_row" })

  # READ
  get("/loans", { :controller => "loans", :action => "index" })
  get("/loans/:id_to_display", { :controller => "loans", :action => "show" })

  # UPDATE
  get("/loans/:prefill_with_id/edit", { :controller => "loans", :action => "edit_form" })
  post("/update_loan/:id_to_modify", { :controller => "loans", :action => "update_row" })

  # DELETE
  get("/delete_loan/:id_to_remove", { :controller => "loans", :action => "destroy_row" })

  #------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

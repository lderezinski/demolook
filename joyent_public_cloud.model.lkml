connection: "joyent"

include: "cnapimonthly.view.lkml"
include: "zuora_customers.view.lkml"
include: "jpc_account_facts.view.lkml"
include: "jpcdaily_spend.view.lkml"
include: "ufds.view.lkml"         # include all views in this project
include: "cnapi.view.lkml"         # include all views in this project
include: "datacenters.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: ufds {

    description: "UFDS"
    group_label: "Joyent Public Cloud"
    label: "ufds"

}
explore: datacenters {

  description: "DC"
  group_label: "Joyent Public Cloud"
  label: "dc"

}
explore: cnapi {

  description: "CNApi"
  group_label: "Joyent Public Cloud"
  label: "cnapi"

}
explore: cnapimonthly {

  description: "CNApi monthly"
  group_label: "Joyent Public Cloud"
  label: "cnapi monthly"

}
explore: jpcdaily_spend {

  description: "Billing Preview spend"
  group_label: "Joyent Public Cloud"
  label: "jpc daily spend"

    join: zuora_customers {
      view_label: "Customers"
      sql_on: ${jpcdaily_spend.accountnumber} = ${zuora_customers.accountnumber} ;;
      type: left_outer
      relationship: many_to_one
    }
    join: jpc_account_facts {
      view_label: "Customers"
      sql_on: ${jpcdaily_spend.accountnumber} = ${jpc_account_facts.account_number} ;;
      type: left_outer
      relationship: many_to_one
    }
}



# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

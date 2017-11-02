connection: "joyent"

include: "cnapimonthly.view.lkml"
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

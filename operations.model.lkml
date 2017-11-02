connection: "sdcdata"

# include all the views
include: "account_facts.view.lkml"
include: "cnapishort.view.lkml"
include: "dailyspend.view.lkml"
include: "zcustomers.view.lkml"
include: "zuoraaccount.view.lkml"
include: "spccnapishort.view.lkml"

# include all the dashboards
#include: "*.dashboard"

explore: cnapishort {
  description: "This data comes from hourly cnapi dumps stripped down to capacity information"
  label: "memory Capacity"
  group_label: "SDC"
}
explore: dailyspend {
  description: "This data comes from BPR files"
  group_label: "BPR"
  join: zcustomers {
    view_label: "Customers"
    sql_on: ${dailyspend.accountnumber} = ${zcustomers.accountnumber} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: account_facts {
    view_label: "Customers"
    sql_on: ${dailyspend.accountnumber} = ${account_facts.account_number} ;;
    type: left_outer
    relationship: many_to_one
  }
}
explore: zcustomers {
  description: "zuora customer list"
  group_label: "Zuora"
  label: "Customers"

}
explore: zuoraaccount {
  description: "Zuora Accounts"
  group_label: "Zuora"
  label: "Accounts"
}
explore: spccnapishort {
  description: "This data comes from hourly cnapi dumps stripped down to capacity information"
  label: "spc memory Capacity"
  group_label: "SCloud"
}

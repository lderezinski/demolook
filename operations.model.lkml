connection: "sdcdata"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: cnapishort {
  description: "This data comes from hourly cnapi dumps stripped down to capacity information"
  label: "memory Capacity"
  group_label: "SDC"
}
explore: dailyspend {
  description: "This data comes from BPR files"
  group_label: "BPR"
}
explore: zcustomers {
  description: "zuora customer list"
  group_label: "Zuora"
  label: "Customers"

}

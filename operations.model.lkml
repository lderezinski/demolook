connection: "sdcdata"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: cnapishort {
  description: "This data comes from hourly cnapi dumps stripped down to capacity information"
  group_label: "memory Capacity"
}

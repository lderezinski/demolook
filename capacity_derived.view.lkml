# If necessary, uncomment the line below to include explore_source.
# include: "joyent_public_cloud.model.lkml"

view: capacity_derived {
  derived_table: {
    explore_source: storagebuild {
      column: region_status {}
      column: deliver_date {
        field: storagebuild.deliver_raw
      }
      column: sold_out_date {}
      column: sum_manta_cap_pib {}
    }
  }
  dimension: region_status {}
  dimension_group: deliver {
    description: "Delivery date"
    type: time
    sql: ${TABLE}.deliver_date ;;
  }
  dimension: sold_out_date {
    description: "Date it will be sold out"
    type: date
  }
  dimension: sum_manta_cap_pib {
    description: "The manta capacity in PiB"
    type: number
  }
}

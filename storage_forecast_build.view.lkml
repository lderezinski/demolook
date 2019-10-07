# If necessary, uncomment the line below to include explore_source.
# include: "joyent_public_cloud.model.lkml"

view: storage_forecast_build {
  derived_table: {
    explore_source: storageforecast {
      column: delivery_raw {}
      column: region {
        field: step_storageforecast.region
      }
      column: halfyear_target { field: step_storageforecast.halfyear_target }
      filters: {
        field: step_storageforecast.group
        value: "SPC"
      }

    }
  }

  dimension: primkey {
    hidden: yes
    primary_key: yes
    sql: ${region} || ${delivery_raw}::TEXT  ;;
  }

  dimension: region {
    hidden: yes
  }
  dimension_group: delivery {
    description: "How much PiB will be delivered"
    type: time
    sql:  ${TABLE}.delivery_raw ;;
  }
  dimension: build_duration{
    description: "How long the build will take in months"
    type: number
      sql:  6 ;;
  }

  dimension_group: build_start {
    description: "The start time of the Build"
    type: time
    sql:  ${delivery_raw} - interval '${build_duration} months';;
  }

  dimension: halfyear_target_raw {
    description: "Which half year this is targeted to deliver in"
    hidden: yes
    type: number
    sql: ${TABLE}.halfyear_target ;;
  }

  measure: halfyear_target {
    description: "Sum of the halfyear_target"
    type: sum
    sql:  ${halfyear_target_raw} ;;
  }
}

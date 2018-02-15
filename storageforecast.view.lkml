view: storageforecast {
  sql_table_name: capacity.storageforecast ;;

  dimension: cumulative_data_pib {
    type: number
    sql: ${TABLE}."cumulative_data_PiB" ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."Date" ;;
  }

  dimension: fcst {
    type: string
    sql: ${TABLE}."FCST" ;;
  }

  dimension: group {
    type: string
    sql: ${TABLE}."group" ;;
  }

  dimension: manta_capacity_pib {
    type: number
    sql: ${TABLE}."Manta_capacity_PiB" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."Region" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: sum_manta_cap_pib {
    type: sum
    sql: ${manta_capacity_pib} ;;
  }
  measure: sum_cum_data_pib {
    type: sum
    sql: ${cumulative_data_pib} ;;
  }
}

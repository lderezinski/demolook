view: storagebuild {
  sql_table_name: capacity.storagebuild ;;

  dimension_group: deliver {
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
    sql: ${TABLE}."DeliverDate" ;;
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

  dimension_group: start {
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
    sql: ${TABLE}."StartDate" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."Status" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum_manta_cap_pib {
    type: sum
    sql: ${manta_capacity_pib} ;;
  }
}

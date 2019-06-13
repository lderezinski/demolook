view: status_hours {
  sql_table_name: uptime.status_hours ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."date" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."region" ;;
  }

  dimension: uptime {
    type: number
    sql: ${TABLE}."value" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: uptime_sum{
    type: sum
    sql:  ${TABLE}."value" ;;
  }

}

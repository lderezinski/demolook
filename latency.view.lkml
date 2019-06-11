view: latency {
  sql_table_name: uptime.latency ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."date"  || ${TABLE}."region" || ${TABLE}."type";;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      time,
      hour,
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

  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}."value" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: five_minute_moving_avg{
    type: average
    sql:  ${TABLE}."value" ;;
  }
}

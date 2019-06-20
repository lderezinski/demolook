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
    drill_fields: [value,region,date_date,type]
  }

  dimension: region {
    type: string
    sql: ${TABLE}."region" ;;
    drill_fields: [value,region,date_date,type]
  }

  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
    drill_fields: [value,region,date_date,type]
  }

  dimension: value {
    type: number
    sql: ${TABLE}."value" ;;
    drill_fields: [value,region,date_date,type]
  }

  measure: count {
    type: count
    drill_fields: [value,region,date_date,type]
  }
  measure: five_minute_moving_avg{
    type: average
    sql:  ${TABLE}."value" ;;
    drill_fields: [value,region,date_date,type]
  }
}

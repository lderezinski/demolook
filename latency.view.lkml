view: latency {
  sql_table_name: uptime.latency ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date  || ${TABLE}.region || ${TABLE}."TYPE";;
  }

  dimension_group: date {
    description: "timestamp of the data collection"
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

    sql: ${TABLE}.date ;;
    drill_fields: [value,region,date_date,type]
  }

  dimension: region {
    description: "Name of the region"
    type: string
    sql: ${TABLE}.region ;;
    drill_fields: [value,region,date_date,type]
  }

  dimension: type {
    description: "90% or 95% data"
    type: string
    sql: ${TABLE}."TYPE" ;;
    drill_fields: [value,region,date_date,type]
  }

  dimension: value {
    description: "the muskie latency in ms"
    type: number
    sql: ${TABLE}.value ;;
    drill_fields: [value,region,date_date,type]
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [value,region,date_date,type]
  }
  measure: five_minute_moving_avg{
    description: "latency five minute moving average"
    type: average
    sql:  ${TABLE}.value ;;
    drill_fields: [value,region,date_date,type]
  }
}

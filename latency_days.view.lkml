view: latency_days {
  sql_table_name: uptime.latency_days ;;

  dimension: compound_primary_key {
    description: ""
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date  || ${TABLE}.region || ${TABLE}."TYPE";;
  }

  dimension_group: date {
    description: "timestamp of the data collection"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
    drill_fields: [latency,region,date_date,type]
  }

  dimension: region {
    description: "Name of the region"
    type: string
    sql: ${TABLE}.region ;;
    drill_fields: [latency,region,date_date,type]
  }

  dimension: type {
    description: "90% or 95%"
    type: string
    sql: ${TABLE}."TYPE" ;;
    drill_fields: [latency,region,date_date,type]
  }

  dimension: latency {
    description: "the muskie latency in ms"
    type: number
    sql: ${TABLE}.value ;;
    value_format_name: percent_1
    drill_fields: [latency,region,date_date,type]
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [latency,region,date_date,type]
  }
  measure: latency_sum{
    description: "Sum of muskie latency"
    type: sum
    sql:  ${TABLE}.value ;;
    value_format_name: percent_1
    drill_fields: [latency,region,date_date,type]
  }

  measure: latency_avg{
    description: "Average of muskie latency"
    type: average
    sql:  ${TABLE}.value ;;
    value_format_name: percent_1
    drill_fields: [latency,region,date_date,type]
  }
}

view: status_days {
  sql_table_name: uptime.status_days ;;

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
    drill_fields: [uptime,region,date_date]
  }

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date  || ${TABLE}.region ;;
  }

  dimension: region {
    description: "Name of the region"
    type: string
    sql: ${TABLE}.region ;;
    drill_fields: [uptime,region,date_date]
  }

  dimension: uptime {
    description: "Uptime percentage"
    type: number
    sql: ${TABLE}.value ;;
    value_format_name: percent_1
    drill_fields: [uptime,region,date_date]
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [uptime,region,date_date]
  }
  measure: uptime_sum{
    description: "Sum of the uptime"
    type: sum
    sql:  ${TABLE}.value ;;
    value_format_name: percent_1
    drill_fields: [uptime,region,date_date]
  }
}

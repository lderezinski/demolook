view: latency_hours {
  sql_table_name: uptime.latency_hours ;;

  dimension_group: date {
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
    sql: ${TABLE}."date" ;;
    drill_fields: [latency,region,date_date,type]
  }

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."date"  || ${TABLE}."region" || ${TABLE}."type";;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."region" ;;
    drill_fields: [latency,region,date_date,type]
  }

  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
    drill_fields: [latency,region,date_date,type]
  }

    dimension: latency {
      type: number
      sql: ${TABLE}."value" ;;
      value_format_name: percent_1
      drill_fields: [latency,region,date_date,type]
    }

    measure: count {
      type: count
      drill_fields: [latency,region,date_date,type]
    }
    measure: latency_sum{
      type: sum
      sql:  ${TABLE}."value" ;;
      value_format_name: percent_1
      drill_fields: [latency,region,date_date,type]
    }

    measure: latency_avg{
      type: average
      sql:  ${TABLE}."value" ;;
      value_format_name: percent_1
      drill_fields: [latency,region,date_date,type]
    }
}

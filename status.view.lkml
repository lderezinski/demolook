view: status {
  sql_table_name: uptime.status ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."date"  || ${TABLE}."region" || ${TABLE}."httpcode";;
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
    sql: ${TABLE}."date" ;;
    drill_fields: [httpcode,region,value,date_date]
  }

  dimension: httpcode {
    type: number
    sql: ${TABLE}."httpcode" ;;
    drill_fields: [httpcode,region,value,date_date]
  }
dimension: code_buckets {
  type: tier
  tiers: [200,300,400,500]
  style: integer
  drill_fields: [httpcode,region,value,date_time]
  sql: ${TABLE}."httpcode"  ;;
}
  dimension: region {
    description: "Name of the region"
    type: string
    sql: ${TABLE}."region" ;;
    drill_fields: [httpcode,region,value,date_date]
  }

  dimension: value {
    description: "Number of http codes found"
    type: number
    sql: ${TABLE}."value" ;;
    drill_fields: [httpcode,region,value,date_date]
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [httpcode,region,value,date_date]
  }
  measure: five_minute_moving_avg{
    type: average
    sql:  ${TABLE}."value" ;;
    drill_fields: [httpcode,region,value,date_date]
  }
  measure: five_minute_sum{
    type: sum
    sql:  ${TABLE}."value" ;;
    drill_fields: [httpcode,region,value,date_date]
  }
}

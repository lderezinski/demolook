view: status {
  sql_table_name: uptime.status ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."date"  || ${TABLE}."region" || ${TABLE}."httpcode";;
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

  dimension: httpcode {
    type: string
    sql: ${TABLE}."httpcode" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."region" ;;
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

view: status_months {
  sql_table_name: uptime.status_months ;;

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
  }

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."date"  || ${TABLE}."region" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."region" ;;
  }

  dimension: uptime {
    type: number
    sql: ${TABLE}."value" ;;
    value_format_name: percent_1
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: uptime_sum{
    type: sum
    sql:  ${TABLE}."value" ;;
    value_format_name: percent_2
  }


}

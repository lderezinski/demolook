view: zdailyspend {
  sql_table_name: smartdc.zdailyspend ;;

  dimension: accountnumber {
    type: string
    sql: ${TABLE}.accountnumber ;;
  }

  dimension_group: day {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.day ;;
  }

  dimension: jpcspend {
    type: number
    sql: ${TABLE}.jpcspend ;;
  }

  dimension: jpctotal {
    type: number
    sql: ${TABLE}.jpctotal ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

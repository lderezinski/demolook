view: dailyspend {
  sql_table_name: public.dailyspend ;;

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
  measure: monthToDate {
    type:  sum
    sql: ${jpcspend} ;;
    drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
  }
  measure: notJPCSpend {
    type: number
    sql: ${total} - ${jpcspend} ;;
    drill_fields: [accountnumber,day_date]
  }
  measure: sum_spend {
    type: sum
    sql: ${spend} ;;
    drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
  }
}

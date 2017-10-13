view: zcustomers {
  sql_table_name: public.zcustomers ;;

  dimension: accountnumber {
    type: string
    sql: ${TABLE}.accountnumber ;;
  }

  dimension: batch {
    type: string
    sql: ${TABLE}.batch ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension_group: createddate {
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
    sql: ${TABLE}.createddate ;;
  }

  dimension: zuoraid {
    type: string
    sql: ${TABLE}.zuoraid ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: updataloaded {
  sql_table_name: uptime.dataloaded ;;

  dimension: totalcount {
    type: number
    sql: ${TABLE}."count" ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      hour,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."date" ;;
  }

  dimension: tablename {
    type: string
    sql: ${TABLE}."tablename" ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [tablename]
  }
}

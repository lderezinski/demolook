view: updataloaded {
  sql_table_name: uptime.dataloaded ;;

  dimension: totalcount {
    description: "1 or the number of objects loaded"
    type: number
    sql: ${TABLE}."count" ;;
  }

  dimension_group: date {
    description: "The date the data was loaded into postgres"
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
    description: "The name of the table the data was loaded into"
    type: string
    sql: ${TABLE}."tablename" ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [tablename]
  }
}

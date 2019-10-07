view: sdcdataloaded {
  sql_table_name: smartdc.dataloaded ;;

  dimension: totalcount {
    description: "A non null or non zero value means data successfully loaded"
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension_group: date {
    description: "Timestamp of dataloaded"
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
    sql: ${TABLE}.date ;;
  }

  dimension: tablename {
    description: "The name of the table "
    type: string
    sql: ${TABLE}.tablename ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [tablename]
  }
}

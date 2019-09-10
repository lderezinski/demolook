view: capdataloaded {
  sql_table_name: capacity.dataloaded ;;

  dimension: totalcount {
    description: "Count of capacity data"
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension_group: date {
    description: "Timestamp when data was loaded"
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
    sql: ${TABLE}.date ;;
  }

  dimension: tablename {
    description: "The name of the table data was loaded"
    type: string
    sql: ${TABLE}.tablename ;;
  }

  measure: count {
    description: "Count of entries"
    type: count
    drill_fields: [tablename]
  }
}

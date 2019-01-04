view: capdataloaded {
  sql_table_name: capacity.dataloaded ;;

  dimension: totalcount {
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension_group: date {
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
    type: string
    sql: ${TABLE}.tablename ;;
  }

  measure: count {
    type: count
    drill_fields: [tablename]
  }
}

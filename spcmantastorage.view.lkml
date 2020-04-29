view: spcmantastorage {
  sql_table_name: smartdc.spcmantastorage ;;

  dimension: bytes {
    type: number
    sql: ${TABLE}.bytes ;;
  }

  dimension: objectcount {
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension_group: date {
    description: "Day of the collection, updated every hour"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: data_k {
    type: sum
    sql: ${bytes}/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: data_m {
    type: sum
    sql: ${bytes}/1024/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: data_g {
    type: sum
    sql: ${bytes}/1024/1024/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: data_t {
    type: sum
    sql: ${bytes}/1024/1024/1024/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: data_p {
    type: sum
    sql: ${bytes}/1024/1024/1024/1024/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: sumobjects {
    type: sum
    sql: ${objectcount} ;;
  }
}

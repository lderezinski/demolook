view: spcmantastorage {
  sql_table_name: smartdc.spcmantastorage ;;

  dimension: bytes {
    type: number
    sql: ${TABLE}."bytes" ;;
  }

  dimension: objectcount {
    type: number
    sql: ${TABLE}."count" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."region" ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}."timestamp" ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}."uuid" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: data_k {
    type: sum
    sql: ${bytes}/1024.0 ;;
  }
  measure: data_m {
    type: sum
    sql: ${bytes}/1024/1024.0 ;;
  }
  measure: data_g {
    type: sum
    sql: ${bytes}/1024/1024/1024.0 ;;
  }
  measure: data_t {
    type: sum
    sql: ${bytes}/1024/1024/1024/1024.0 ;;
  }
  measure: data_p {
    type: sum
    sql: ${bytes}/1024/1024/1024/1024/1024.0 ;;
  }
  measure: sumobjects {
    type: sum
    sql: ${objectcount} ;;
  }
}

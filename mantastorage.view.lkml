view: mantastorage {
  sql_table_name: smartdc.mantastorage ;;


  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."date"  || ${TABLE}."owner" || ${TABLE}."type";;
  }


  dimension: bytes {
    type: number
    sql: ${TABLE}.bytes ;;
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

  dimension: directories {
    type: number
    sql: ${TABLE}.directories ;;
  }

  dimension: keys {
    type: number
    sql: ${TABLE}.keys ;;
  }

  dimension: objects {
    type: number
    sql: ${TABLE}.objects ;;
  }

  dimension: owner {
    type: string
    sql: ${TABLE}.owner ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: sumbytes {
    type: sum_distinct
    sql: ${bytes} ;;
  }
  measure: sumbytes_g {
    type: sum_distinct
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
  }
  measure: sumbytes_t {
    type: sum_distinct
    sql: ${bytes}/1024.0/1024.0/1024.0/1024.0 ;;
  }
  measure: sumbytes_p {
    type: sum_distinct
    sql: ${bytes}/1024.0/1024.0/1024.0/1024.0/1024.0 ;;
  }

}

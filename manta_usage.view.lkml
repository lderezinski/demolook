view: manta_usage {
  sql_table_name: capacity.manta_usage ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."date"  || ${TABLE}."region" || ${TABLE}."login";;
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
    sql: ${TABLE}."date" ;;
  }

  dimension: login {
    type: string
    sql: ${TABLE}."login" ;;
  }

  dimension: object_count {
    type: number
    sql: ${TABLE}."object_count" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."region" ;;
  }

  dimension: used_bytes {
    type: number
    sql: ${TABLE}."used_bytes" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: used_kib {
    type: sum
    sql: ${used_bytes} / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: used_mib {
    type: sum
    sql: ${used_bytes} / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: used_gib {
    type: sum
    sql: ${used_bytes} / 1024.0 / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: used_tib {
    type: sum
    sql: ${used_bytes} / 1024.0 / 1024.0 / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: used_pib {
    type: sum
    sql: ${used_bytes} / 1024.0 / 1024.0 / 1024.0 / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: total_objects_million {
    type: sum
    sql: ${object_count}/1000000.0 ;;
    value_format_name: decimal_2
  }
}

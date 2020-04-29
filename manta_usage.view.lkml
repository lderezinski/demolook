view: manta_usage {
  sql_table_name: capacity.manta_usage ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date  || ${TABLE}.region || ${TABLE}.login;;
  }

  dimension_group: date {
    description: "Timestamp of data collected"
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

  dimension: login {
    description: "UFDS login for account"
    type: string
    sql: ${TABLE}.login ;;
  }

  dimension: object_count {
    description: "The total number of objects for this account"
    type: number
    sql: ${TABLE}.object_count ;;
  }

  dimension: region {
    description: "Region of manta"
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: used_bytes {
    description: "amount of manta data in bytes"
    type: number
    sql: ${TABLE}.used_bytes ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: used_kib {
    description: "amount of manta data in KiB"
    type: sum
    sql: ${used_bytes} / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: used_mib {
    description: "amount of manta data in MiB"
    type: sum
    sql: ${used_bytes} / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: used_gib {
    description: "amount of manta data in GiB"
    type: sum
    sql: ${used_bytes} / 1024.0 / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: used_tib {
    description: "amount of manta data in TiB"
    type: sum
    sql: ${used_bytes} / 1024.0 / 1024.0 / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: used_pib {
    description: "amount of manta data in PiB"
    type: sum
    sql: ${used_bytes} / 1024.0 / 1024.0 / 1024.0 / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
  }
  measure: total_objects_million {
    description: "Total count of manta objects in millions"
    type: sum
    sql: ${object_count}/1000000.0 ;;
    value_format_name: decimal_2
  }
}

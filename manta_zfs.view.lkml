view: manta_zfs {
  sql_table_name: capacity.manta_zfs ;;

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

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: zfs_available_bytes {
    type: number
    sql: ${TABLE}.zfs_available/2 ;;
    value_format_name: decimal_2
  }

  dimension: zfs_used_bytes {
    type: number
    sql: ${TABLE}.zfs_used/2 ;;
    value_format_name: decimal_2
  }
  dimension: zfs_available_pib {
    type: number
    sql: ${zfs_available_bytes}/1125899906842624.0 ;;
    value_format_name: decimal_2
  }

  dimension: zfs_used_pib {
    type: number
    sql: ${zfs_used_bytes}/1125899906842624.0 ;;
    value_format_name: decimal_2
  }
  measure: count {
    type: count
    drill_fields: []
  }
  measure: total_pib {
    type:  sum
    sql: ${zfs_used_pib} + ${zfs_available_pib} ;;
    drill_fields: [date_date,region,zfs_used_pib,zfs_available_pib]
    value_format_name: decimal_2
  }
  measure: total_used_pib {
    type:  sum
    sql: ${zfs_used_pib} ;;
    drill_fields: [date_date,region,zfs_used_pib,zfs_available_pib]
    value_format_name: decimal_2
  }
  measure: total_available_pib {
    type:  sum
    sql: ${zfs_available_pib} ;;
    drill_fields: [date_date,region,zfs_used_pib,zfs_available_pib]
    value_format_name: decimal_2
  }
}

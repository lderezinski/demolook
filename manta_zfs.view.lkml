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
    sql: ${TABLE}.zfs_available ;;
  }

  dimension: zfs_used_bytes {
    type: number
    sql: ${TABLE}.zfs_used ;;
  }
  measure: zfs_available_pib {
    type: number
    sql: ${zfs_available_bytes}/1125899906842624.0 ;;
  }

  measure: zfs_used_pib {
    type: number
    sql: ${zfs_used_bytes}/1125899906842624.0 ;;
  }
  measure: count {
    type: count
    drill_fields: []
  }
}

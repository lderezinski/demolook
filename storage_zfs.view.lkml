view: storage_zfs {
  sql_table_name: capacity.storage_zfs ;;

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

  dimension: instance {
    type: string
    sql: ${TABLE}."instance" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."region" ;;
  }

  dimension: zfs_available {
    type: number
    sql: ${TABLE}."zfs_available" ;;
  }

  dimension: zfs_used {
    type: number
    sql: ${TABLE}."zfs_used" ;;
  }
  dimension: zfs_total {
    type: number
    sql: ${zfs_available}+${zfs_used} ;;
  }
  dimension: percent_used {
    type: number
    sql:  ${zfs_used}/${zfs_total};;
  }
  dimension: percent_free {
    type: number
    sql: ${zfs_available}/${zfs_total} ;;
  }
  measure: count {
    type: count
    drill_fields: []
  }
  measure: sum_total {
    type: sum
    sql: ${zfs_total} ;;
  }
  measure: sum_used {
    type: sum
    sql: ${zfs_used} ;;
  }
  measure: sum_available {
    type: sum
    sql: ${zfs_available} ;;
  }
  measure: sum_percent_free {
    type: number
    sql: ${sum_available}/${sum_total};;
  }
  measure: sum_percent_used {
    type: number
    sql: ${sum_used}/${sum_total} ;;
  }
}

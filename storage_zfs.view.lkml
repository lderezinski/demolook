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

  dimension: zfs_available_t {
    type: number
    sql: ${zfs_available}/1024.0/1024.0/1024.0/1024.0 ;;
  }

  dimension: zfs_used_t {
    type: number
    sql: ${zfs_used}/1024.0/1024.0/1024.0/1024.0 ;;
  }
  dimension: zfs_total_t {
    type: number
    sql: ${zfs_total}/1024.0/1024.0/1024.0/1024.0 ;;
  }
  dimension: percent_used {
    type: number
    sql:  ${zfs_used}*100.0/${zfs_total};;
    value_format_name: decimal_2
  }
  dimension: percent_free {
    type: number
    sql: ${zfs_available}*100.0/${zfs_total} ;;
    value_format_name: decimal_2
  }
  dimension: percent_used_tier {
    description:""
    type:  tier
    tiers: [0,25,50,75,90,95,96,97,98,99,100]
    sql:  ${percent_used} ;;
    style: relational
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
    sql: ${zfs_available_t} ;;
  }
  measure: sum_total_t {
    type: sum
    sql: ${zfs_total_t} ;;
  }
  measure: sum_used_t {
    type: sum
    sql: ${zfs_used_t} ;;
  }
  measure: sum_available_t {
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

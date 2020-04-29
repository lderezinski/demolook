view: makotomb {
  sql_table_name: smartdc.makotomb ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.account || ${TABLE}.name  ;;
  }

  dimension: account {
    description: "UFDS UUID account"
    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: average_size_kb {
    description: "accounts average object size of tombstone object in KiB"
    type: number
    sql: ${TABLE}.average_size_kb ;;
  }

  dimension: bytes {
    description: "Accounts total number of bytes in tombstone"
    type: number
    sql: ${TABLE}.bytes ;;
  }

  dimension: kilobytes {
    description: "Accounts total number of KiB in tombstone"
    type: number
    sql: ${TABLE}.kilobytes ;;
  }

  dimension: name {
    description: "tombstone name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: objects {
    description: "Accounts total number of objects in the tombstone"
    type: number
    sql: ${TABLE}.objects ;;
  }

  dimension: region {
    description: "Region for the tombstone"
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension_group: tombdate {
    description: "date data was collected"
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
    sql: ${TABLE}.tombdate ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [name]
  }

  measure: sum_p {
    description: "total amount of PiB in tombstone"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_t {
    description: "total amount of TiB in tombstone"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_g {
    description: "total amount of GiB in tombstone"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: total_objects {
    description: "total number of objects in tombstone"
    type:  sum
    sql: ${objects} ;;
  }

}

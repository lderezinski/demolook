view: mako {
  sql_table_name: smartdc.mako ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.account || ${TABLE}.name  ;;
  }
  dimension: account {
    description: "UFDS UUID account number"
    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: average_size_kb {
    description: "Average size of objects in kb"
    type: number
    sql: ${TABLE}.average_size_kb ;;
  }

  dimension: bytes {
    description: "number of bytes of storage"
    type: number
    sql: ${TABLE}.bytes ;;
  }

  dimension: kilobytes {
    description: "number of kilobytes of storage"
    type: number
    sql: ${TABLE}.kilobytes ;;
  }

  dimension: name {
    description: "Name of the shard"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: objects {
    description: "number of objects which are ready to be deleted"
    type: number
    sql: ${TABLE}.objects ;;
  }

  dimension: region {
    description: "Name of the region"
    type: string
    sql: ${TABLE}.region ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [name]
  }
  measure: sum_p {
    description: "Size of objects in PiB"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_t {
    description: "Size of objects in TiB"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_g {
    description: "Size of objects in GiB"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: total_objects {
    description: "Total number of objects"
    type:  sum
    sql: ${objects} ;;
  }
  measure: total_avg_object_size {
    description: "Total average object size"
    type: average
    sql: ${kilobytes}/${objects};;
    value_format_name: decimal_3
  }
}

view: mako {
  sql_table_name: smartdc.mako ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.account || ${TABLE}.name  ;;
  }
  dimension: account {
    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: average_size_kb {
    type: number
    sql: ${TABLE}."average size kb" ;;
  }

  dimension: bytes {
    type: number
    sql: ${TABLE}.bytes ;;
  }

  dimension: kilobytes {
    type: number
    sql: ${TABLE}.kilobytes ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: objects {
    type: number
    sql: ${TABLE}.objects ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
  measure: sum_p {
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0/1024.0 ;;
  }
  measure: sum_t {
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0 ;;
  }
  measure: sum_g {
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0 ;;
  }
  measure: total_objects {
    type:  sum
    sql: ${objects} ;;
  }
  measure: total_avg_object_size {
    type: average
    sql: ${kilobytes}/${objects};;
  }
}

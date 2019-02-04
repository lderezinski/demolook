view: makoregion {
  sql_table_name: smartdc.makoregion ;;

  dimension: avg {
    type: number
    sql: ${TABLE}.avg ;;
  }

  dimension: datacenter {
    type: string
    sql: ${TABLE}.datacenter ;;
  }

  dimension: kilobytes {
    type: number
    sql: ${TABLE}.kilobytes ;;
  }

  dimension: objects {
    type: number
    sql: ${TABLE}.objects ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: storage_id {
    type: string
    sql: ${TABLE}.storage_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
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

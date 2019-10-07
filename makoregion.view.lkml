view: makoregion {
  sql_table_name: smartdc.makoregion ;;

  dimension: avg {
    description: "Average amount of objects to be deleted"
    type: number
    sql: ${TABLE}.avg ;;
  }

  dimension: datacenter {
    description: "datacenter name"
    type: string
    sql: ${TABLE}.datacenter ;;
  }

  dimension: kilobytes {
    description: "kilobytes of objects to be deleted"
    type: number
    sql: ${TABLE}.kilobytes ;;
  }

  dimension: objects {
    description: "number of objects to be deleted"
    type: number
    sql: ${TABLE}.objects ;;
  }
  dimension: cloud {
    description: "JPC or SPC"
    type: string
    sql: ${TABLE}.cloud ;;
  }
  dimension: region {
    description: "Name of the region"
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: storage_id {
    description: "The mako ID number"
    primary_key: yes
    type: string
    sql: ${TABLE}.storage_id ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: sum_p {
    description: "Sum of objects to be deleted PiB"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_t {
    description: "Sum of objects to be deleted TiB"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_g {
    description: "Sum of objects to be deleted GiB"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: total_objects {
    description: "Sum of the count of all objects to be deleted"
    type:  sum
    sql: ${objects} ;;
  }
  measure: total_avg_object_size {
    description: "Average of the averages object size"
    type: average
    sql: ${kilobytes}/${objects};;
    value_format_name: decimal_3
  }
}

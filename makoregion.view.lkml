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
  dimension: cloud {
    type: string
    sql: when case region = 'us-east-1' then 'JPC'
              case region = 'us-east-2' then 'JPC'
              case region = 'us-east-3' then 'JPC'
              else 'SPC'
        end ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: storage_id {
    primary_key: yes
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
    value_format_name: decimal_3
  }
  measure: sum_t {
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_g {
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: total_objects {
    type:  sum
    sql: ${objects} ;;
  }
  measure: total_avg_object_size {
    type: average
    sql: ${kilobytes}/${objects};;
    value_format_name: decimal_3
  }
}

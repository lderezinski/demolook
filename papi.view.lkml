view: papi {
  sql_table_name: smartdc.papi ;;

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: billing_tag {
    type: string
    sql: ${TABLE}.billing_tag ;;
  }

  dimension: common_name {
    type: string
    sql: ${TABLE}.common_name ;;
  }

  dimension: cpu_cap {
    type: number
    sql: ${TABLE}.cpu_cap ;;
  }

  dimension: fss {
    type: number
    sql: ${TABLE}.fss ;;
  }

  dimension: group {
    type: string
    sql: ${TABLE}."group" ;;
  }

  dimension: max_lwps {
    type: number
    sql: ${TABLE}.max_lwps ;;
  }

  dimension: max_physical_memory {
    type: number
    sql: ${TABLE}.max_physical_memory ;;
  }

  dimension: max_swap {
    type: number
    sql: ${TABLE}.max_swap ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: quota {
    type: number
    sql: ${TABLE}.quota ;;
  }
  dimension: quota_g {
    type: number
    sql: ${TABLE}.quota/1024/1024 ;;
  }
  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: v {
    type: number
    sql: ${TABLE}.v ;;
  }

  dimension: vcpus {
    type: number
    sql: ${TABLE}.vcpus ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: zfs_io_priority {
    type: number
    sql: ${TABLE}.zfs_io_priority ;;
  }

  measure: count {
    type: count
    drill_fields: [name, common_name]
  }
  measure: total_ram_g {
    type:  sum
    sql:   ${max_physical_memory}/1024;;
  }
  measure: total_disk_g {
  type: sum
  sql:  ${quota_g};;
  }
  measure: total_ram_t {
    type:  sum
    sql:   ${max_physical_memory}/1024/1024;;
  }
  measure: total_disk_t {
    type: sum
    sql:  ${quota_g}/1024;;
  }

}

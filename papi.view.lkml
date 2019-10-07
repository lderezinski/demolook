view: papi {
  sql_table_name: smartdc.papi ;;

  dimension: active {
    description: "boolean papi.active is this package currently active"
    type: yesno
    sql: ${TABLE}.active ;;
  }
  dimension: dcgroup {
    description: "papi.dcgroup "
    type: string
    sql: ${TABLE}.dcgroup ;;
  }
  dimension: billing_tag {
    description: "papi.billing_tag"
    type: string
    sql: ${TABLE}.billing_tag ;;
  }

  dimension: common_name {
    description: "papi.common_name"
    type: string
    sql: ${TABLE}.common_name ;;
  }
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.uuid|| ${TABLE}.name || ${TABLE}.version || ${TABLE}.dcgroup;;
  }
  dimension: cpu_cap {
    description: "papi.cpu_cap"
    type: number
    sql: ${TABLE}.cpu_cap ;;
  }

  dimension: fss {
    description: "papi.fss"
    type: number
    sql: ${TABLE}.fss ;;
  }

  dimension: group {
    description: "papi.group"
    type: string
    sql: ${TABLE}."group" ;;
  }

  dimension: max_lwps {
    description: "papi.max_lwps"
    type: number
    sql: ${TABLE}.max_lwps ;;
  }

  dimension: max_physical_memory {
    description: "papi.max_physical_memory"
    type: number
    sql: ${TABLE}.max_physical_memory ;;
  }

  dimension: max_swap {
    description: "papi.max_swap"
    type: number
    sql: ${TABLE}.max_swap ;;
  }

  dimension: name {
    description: "papi.name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: quota {
    description: "papi.quota"
    type: number
    sql: ${TABLE}.quota ;;
  }
  dimension: quota_g {
    description: "papi.quota in GiB"
    type: number
    sql: ${TABLE}.quota/1024.0/1024.0 ;;
    value_format_name: decimal_2
  }
  dimension: uuid {
    description: "papi.uuid for this package"
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: v {
    description: "papi.v version of JSON format"
    type: number
    sql: ${TABLE}.v ;;
  }

  dimension: vcpus {
    description: "papi.vcpus"
    type: number
    sql: ${TABLE}.vcpus ;;
  }

  dimension: version {
    description: "papi.version the version of the package"
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: zfs_io_priority {
    description: "papi.zfs_io_priority"
    type: number
    sql: ${TABLE}.zfs_io_priority ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [name, common_name]
  }
  measure: total_ram_g {
    description: "Sum of the max_physical_memory in GiB"
    type:  sum
    sql:   ${max_physical_memory}/1024.0;;
    value_format_name: decimal_2
  }
  measure: total_disk_g {
  description: "Sum of the quota in GiB"
  type: sum
  sql:  ${quota_g};;
  }
  measure: total_ram_t {
    description: "Sum of the max_physical_memory in TiB"
    type:  sum
    sql:   ${max_physical_memory}/1024.0/1024.0;;
    value_format_name: decimal_2
  }
  measure: total_disk_t {
    description: "Sum of the quota in TiB"
    type: sum
    sql:  ${quota_g}/1024.0;;
    value_format_name: decimal_2
  }

}

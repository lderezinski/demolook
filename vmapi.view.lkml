view: vmapi {
  sql_table_name: smartdc.vmapi ;;

  dimension: alias {
    type: string
    sql: ${TABLE}.alias ;;
  }

  dimension: billing_id {
    type: string
    sql: ${TABLE}.billing_id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: cpu_cap {
    type: number
    sql: ${TABLE}.cpu_cap ;;
  }

  dimension: cpu_shares {
    type: number
    sql: ${TABLE}.cpu_shares ;;
  }

  dimension_group: create_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.create_timestamp ;;
  }

  dimension: datacenter {
    type: string
    sql: ${TABLE}.datacenter ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension: dns_domain {
    type: string
    sql: ${TABLE}.dns_domain ;;
  }

  dimension: docker {
    type: yesno
    sql: ${TABLE}.docker ;;
  }

  dimension: hostname {
    type: string
    sql: ${TABLE}.hostname ;;
  }

  dimension: image_uuid {
    type: string
    sql: ${TABLE}.image_uuid ;;
  }

  dimension: kernel_version {
    type: string
    sql: ${TABLE}.kernel_version ;;
  }

  dimension: max_locked_memory {
    type: number
    sql: ${TABLE}.max_locked_memory ;;
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

  dimension: owner_uuid {
    type: string
    sql: ${TABLE}.owner_uuid ;;
  }

  dimension: pid {
    type: number
    value_format_name: id
    sql: ${TABLE}.pid ;;
  }

  dimension: platform_buildstamp {
    type: string
    sql: ${TABLE}.platform_buildstamp ;;
  }

  dimension: quota {
    type: number
    sql: ${TABLE}.quota ;;
  }

  dimension: ram {
    type: number
    sql: ${TABLE}.ram ;;
  }

  dimension: server_uuid {
    type: string
    sql: ${TABLE}.server_uuid ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: tmpfs {
    type: number
    sql: ${TABLE}.tmpfs ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: zfs_io_priority {
    type: number
    sql: ${TABLE}.zfs_io_priority ;;
  }

  dimension: zone_state {
    type: string
    sql: ${TABLE}.zone_state ;;
  }

  dimension: zpool {
    type: string
    sql: ${TABLE}.zpool ;;
  }

  measure: count {
    type: count
    drill_fields: [hostname]
  }
  measure: ram_g {
    type: sum
    sql: ${ram}/1024 ;;
  }
}

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

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.uuid ||  '  ' || ${TABLE}.datacenter || ${TABLE}.owner_uuid  ;;
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

  measure: last_reported_date {
    type: date
    sql: MAX(${date_raw}) ;;
    convert_tz: no
  }

  measure: first_reported_date {
    type: date
    sql: MIN(${date_raw}) ;;
    convert_tz: no
  }

  measure: run_duration {
    type: number
    sql: DATE_PART('day',${last_reported_date}::TIMESTAMP - ${first_reported_date}::TIMESTAMP ) ;;
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
  dimension: ram_lsd {
    type: number
    sql: ${ram}/1024.0 ;;
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


  dimension: tags {
    type: string
    sql: ${TABLE}."tags"::text ;;
  }

  dimension: is_manta_compute {
    type: yesno
    sql: ${TABLE}.tags ->> 'manta_compute' is not null;;
  }

  dimension: manta_compute {
    type: string
    sql: ${TABLE}.tags ->> 'manta_compute' ;;
  }
  dimension: is_manta_role {
    type: yesno
    sql: ${TABLE}.tags ->> 'manta_role' is not null;;

  }
  dimension: manta_role {
    type: string
    sql: ${TABLE}.tags ->> 'manta_role';;
  }
  dimension: is_smartdc_role {
    type: yesno
    sql: ${TABLE}.tags ->> 'smartdc_role' is not null;;

  }
  dimension: smartdc_role {
    type: string
    sql: ${TABLE}.tags ->> 'smartdc_role';;
  }
  dimension: is_smartdc_type {
    type: yesno
    sql: ${TABLE}.tags ->> 'smartdc_type' is not null;;

  }
  dimension: smartdc_type {
    type: string
    sql: ${TABLE}.tags ->> 'smartdc_type';;
  }
  dimension: is_manta_storage {
    type: yesno
    sql: ${TABLE}.tags ->> 'manta_storage_id' is not null;;

  }
  dimension: manta_storage_id {
    type: string
    sql: ${TABLE}.tags ->> 'manta_storage_id';;
  }
  dimension: is_manta_reshard {
    type: yesno
    sql: ${TABLE}.tags ->> 'manta_reshard_plan' is not null;;

  }
  dimension: manta_reshard_plan {
    type: string
    sql: ${TABLE}.tags ->> 'manta_reshard_plan';;
  }

  measure: count {
    type: count
    drill_fields: [hostname]
  }
  measure: ram_g {
    type: sum_distinct
    sql: ${ram}/1024.0 ;;
    value_format_name: decimal_2
    drill_fields: [ufds.display_name,alias,state,ram_g,cnapi.cn_name,datacenter,create_timestamp_date]
  }
  measure: number_of_unique_customers {
    type: count_distinct
    sql: ${owner_uuid} ;;
  }
  measure: number_of_unique_images {
    type: count_distinct
    sql: ${image_uuid} ;;
  }
}

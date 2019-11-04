view: vmapi {
  sql_table_name: smartdc.vmapi ;;

  dimension: alias {
    description: "VMapi.alias"
    type: string
    sql: ${TABLE}.alias ;;
  }

  dimension: billing_id {
    description: "VMapi.billing_id"
    type: string
    sql: ${TABLE}.billing_id ;;
  }

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.uuid ||  '  ' || ${TABLE}.datacenter || ${TABLE}.owner_uuid  || ${TABLE}.date;;
  }
  dimension: brand {
    description: "VMapi.brand, lx, smartOS, KVM, etc"
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: cpu_cap {
    description: "VMapi.cpu_cap"
    type: number
    sql: ${TABLE}.cpu_cap ;;
  }

  dimension: cpu_shares {
    description: "VMapi.cpu_shares"
    type: number
    sql: ${TABLE}.cpu_shares ;;
  }

  dimension_group: create_timestamp {
    description: "VMapi.created"
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
    description: "VMapi.datacenter"
    type: string
    sql: ${TABLE}.datacenter ;;
  }

  dimension_group: date {
    description: "VMapi.date timestamp vm created"
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
    description: "VMapi.date latest value"
    type: date
    sql: MAX(${date_raw}) ;;
    convert_tz: no
  }

  measure: first_reported_date {
    description: "VMapi.date earliest value"
    type: date
    sql: MIN(${date_raw}) ;;
    convert_tz: no
  }

  measure: run_duration {
    description: "Number of days it has been running"
    type: number
    sql: DATE_PART('day',${last_reported_date}::TIMESTAMP - ${first_reported_date}::TIMESTAMP ) ;;
  }

  dimension: dns_domain {
    description: "VMapi.dns_domain"
    type: string
    sql: ${TABLE}.dns_domain ;;
  }

  dimension: docker {
    description: "boolean if this VM is a docker instance"
    type: yesno
    sql: ${TABLE}.docker ;;
  }

  dimension: hostname {
    description: "VMapi.hostname the CN this instance is running on"
    type: string
    sql: ${TABLE}.hostname ;;
  }

  dimension: image_uuid {
    description: "VMapi.image_uuid of this VM"
    type: string
    sql: ${TABLE}.image_uuid ;;
  }

  dimension: kernel_version {
    description: "VMapi.kernel_version min value required to run"
    type: string
    sql: ${TABLE}.kernel_version ;;
  }

  dimension: max_locked_memory {
    description: "VMapi.max_locked_memory"
    type: number
    sql: ${TABLE}.max_locked_memory ;;
  }

  dimension: max_lwps {
    description: "VMapi.max_lwps"
    type: number
    sql: ${TABLE}.max_lwps ;;
  }

  dimension: max_physical_memory {
    description: "VMapi.max_physical_memory"
    type: number
    sql: ${TABLE}.max_physical_memory ;;
  }

  dimension: max_swap {
    description: "VMapi.max_swap"
    type: number
    sql: ${TABLE}.max_swap ;;
  }

  dimension: owner_uuid {
    description: "VMapi.owner_uuid"
    type: string
    sql: ${TABLE}.owner_uuid ;;
  }

  dimension: pid {
    description: "VMapi.pid"
    type: number
    value_format_name: id
    sql: ${TABLE}.pid ;;
  }

  dimension: platform_buildstamp {
    description: "VMapi.platform_buildstamp"
    type: string
    sql: ${TABLE}.platform_buildstamp ;;
  }

  dimension: quota {
    description: "VMapi.quota"
    type: number
    sql: ${TABLE}.quota ;;
  }

  dimension: ram {
    description: "VMapi.ram"
    type: number
    sql: ${TABLE}.ram ;;
  }

  dimension: server_uuid {
    description: "VMapi.server_uuid this instance is running on"
    type: string
    sql: ${TABLE}.server_uuid ;;
  }

  dimension: state {
    description: "VMapi.state"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: tmpfs {
    description: "VMapi.tmpfs"
    type: number
    sql: ${TABLE}.tmpfs ;;
  }

  dimension: uuid {
    description: "VMapi.uuid"
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: zfs_io_priority {
    description: "VMapi.zfs_io_priority"
    type: number
    sql: ${TABLE}.zfs_io_priority ;;
  }

  dimension: zone_state {
    description: "VMapi.zone_state"
    type: string
    sql: ${TABLE}.zone_state ;;
  }

  dimension: zpool {
    description: "VMapi.zpool"
    type: string
    sql: ${TABLE}.zpool ;;
  }


  dimension: tags {
    description: "VMapi.tags"
    type: string
    sql: ${TABLE}."tags"::text ;;
  }

  dimension: is_manta_compute {
    description: "VMapi.tags contains manta_compute"
    type: yesno
    sql: ${TABLE}.tags ->> 'manta_compute' is not null;;
  }

  dimension: manta_compute {
    description: "VMapi.tags[manta_compute]"
    type: string
    sql: ${TABLE}.tags ->> 'manta_compute' ;;
  }
  dimension: is_manta_role {
    description: "boolean VMapi.tags[manta_role] is not null"
    type: yesno
    sql: ${TABLE}.tags ->> 'manta_role' is not null;;

  }
  dimension: manta_role {
    description: "VMapi.tags[manta_role]"
    type: string
    sql: ${TABLE}.tags ->> 'manta_role';;
  }
  dimension: is_smartdc_role {
    description: "boolean VMapi.tags[smartdc_role] is not null"
    type: yesno
    sql: ${TABLE}.tags ->> 'smartdc_role' is not null;;

  }
  dimension: smartdc_role {
    description: " VMapi.tags[smartdc_role]"
    type: string
    sql: ${TABLE}.tags ->> 'smartdc_role';;
  }
  dimension: is_smartdc_type {
    description: "boolean VMapi.tags[smartdc_type] is not null"
    type: yesno
    sql: ${TABLE}.tags ->> 'smartdc_type' is not null;;

  }
  dimension: smartdc_type {
    description: "VMapi.tags[smartdc_type]"
    type: string
    sql: ${TABLE}.tags ->> 'smartdc_type';;
  }
  dimension: is_manta_storage {
    description: "boolean VMapi.tags[manta_storage_id] is not null"
    type: yesno
    sql: ${TABLE}.tags ->> 'manta_storage_id' is not null;;

  }
  dimension: manta_storage_id {
    description: "VMapi.tags[manta_storage_id]"
    type: string
    sql: ${TABLE}.tags ->> 'manta_storage_id';;
  }
  dimension: is_manta_reshard {
    description: "boolean VMapi.tags[manta_reshard_plan] is not null"
    type: yesno
    sql: ${TABLE}.tags ->> 'manta_reshard_plan' is not null;;

  }
  dimension: manta_reshard_plan {
    description: "VMapi.tags[manta_reshard_plan]"
    type: string
    sql: ${TABLE}.tags ->> 'manta_reshard_plan';;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [datacenter,alias,uuid,state,ram_g,create_timestamp_date]
  }
  measure: ram_g {
    description: "Sum of ram in GiB"
    type: sum_distinct
    sql: ${ram}/1024.0 ;;
    value_format_name: decimal_2
    drill_fields: [ufds.display_name,alias,state,ram_g,cnapi.cn_name,datacenter,create_timestamp_date]
  }
  measure: number_of_unique_customers {
    description: "count of distinct Accounts"
    type: count_distinct
    sql: ${owner_uuid} ;;
  }
  measure: number_of_unique_images {
    description: "Count of unique images"
    type: count_distinct
    sql: ${image_uuid} ;;
  }
}

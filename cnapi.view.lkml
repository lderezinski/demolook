# include: "values.view.lkml"

view: cnapi {

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.date.date, '  ', ${TABLE}.cn_name) ;;
  }

  sql_table_name: smartdc.cnapi ;;

  parameter: input_value {
    description: "validates instance ram size"
    type: number
    suggest_explore: ram_values
    suggest_dimension: papi.max_physical_memory
  }

 parameter: disk_footprint {
   description: "Amount of Disk in G"
  type:  number
 }
parameter: cpu {
  description: "dedicated CPU"
  type: number
}

  dimension: boot_platform {
    type: string
    sql: ${TABLE}."boot platform" ;;
  }
  dimension_group: boot_pi_date {
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
    sql: to_date(substring(${boot_platform},1,8),'YYYYMMDD') ;;
  }

  dimension: live_image {
    type: string
    sql: ${TABLE}."live image" ;;
  }
  dimension_group: live_pi_date {
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
    sql: to_date(substring(${live_image},1,8),'YYYYMMDD') ;;
  }


  dimension: live_pi_number {
    type:  number
    sql: to_number(substring(${live_image},1,8),'99999999') ;;
  }


  dimension: months_since_pi{
    type: number
    sql: NOW() - ${live_pi_date_month};;
  }
  dimension: months_pi_tier{
    type: tier
    tiers: [0,1,3,6,12,24, 36,48]
    sql: ${months_since_pi};;
  }

  dimension: cores {
    type: number
    sql: coalesce( ${TABLE}."Cores",0) ;;
  }

  dimension: cpu_cores {
    type: number
    sql: coalesce(${TABLE}.cpu_cores,0) ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}."DATE" ;;
  }

  dimension: is_last_day_of_month{
    type: yesno
    sql: (date_trunc('MONTH', ${date_date}) + INTERVAL '1 MONTH - 1 day')::date = ${date_date};;
  }
  dimension: dc {
    type: string
    sql: ${TABLE}."DCENTER" ;;
  }

  dimension: disk_pool {
    type: number
    sql: coalesce(${TABLE}."disk pool size G",0) ;;
  }

  dimension: ram_free {
    type: number
    sql: coalesce(${TABLE}."Free",0) ;;
  }

  dimension: cn_name {
    type: string
    sql: upper(${TABLE}."HOSTNAME") ;;
  }
  dimension: role {
    type: string
    sql:  CASE
            WHEN ${traits} LIKE '%headnode%' THEN 'Headnode'
            WHEN ${cn_name} = 'headnode' THEN 'Headnode'
            ELSE
              CASE
                WHEN ${traits} LIKE '%manta%'  THEN 'Manta'
                WHEN ${traits} LIKE '%bhyve_true%' THEN 'bhyve'
                ELSE 'Compute'
              END
            END;;
  }
  dimension: hwfamily {
    type: string
    sql: ${TABLE}."HWFamily" ;;
  }

  dimension: hwversion {
    type: string
    sql: ${TABLE}."HWversion" ;;
  }

  dimension: joy_num {
    type: number
    sql: coalesce(${TABLE}."joyent",0) ;;
  }

  dimension: joyent_percent {
    type: number
    sql: coalesce( ${TABLE}."%joyent",0) ;;
  }

  dimension: kvm_num {
    type: number
    sql:coalesce( ${TABLE}."kvm",0) ;;
  }

  dimension: kvm_percent {
    type: number
    sql:coalesce( ${TABLE}."%kvm",0) ;;
  }

  dimension_group: last_boot {
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
    sql: ${TABLE}.last_boot ;;
  }

  dimension: num_lx {
    type: number
    sql: ${TABLE}."lx" ;;
  }

  dimension: lx_percent {
    type: number
    sql: coalesce( ${TABLE}."%lx", 0) ;;
  }

  dimension: cn_minimal {
    type: number
    sql: coalesce(${TABLE}."minimal",0) ;;
  }

  dimension: minimal_percent {
    type: number
    sql:coalesce( ${TABLE}."%minimal",0) ;;
  }
  dimension: trait_types {
    type:  string
    sql:  json_object_keys(${TABLE}.traits) ;;
  }

  # https://github.com/joyent/opstools/blob/master/src/bin/ops-cnsetup#L354-L430
  dimension: cn_model {
    type: string
     sql: ${TABLE}."Model" ;;
    # sql: CASE
    ##    WHEN substring(${cn_name},1, 2) = 'HA' THEN 'Hallasan-A'
    #    WHEN substring(${cn_name},1, 2) = 'HB' THEN 'Hallasan-B'
    #    WHEN substring(${cn_name},1, 2) = 'HC' THEN 'Hallasan-C'
    #    WHEN substring(${cn_name},1, 2) = 'HE' THEN 'Headnode'
    #    WHEN substring(${cn_name},1, 2) = 'MS' THEN 'Mantis Shrimp MkII'
    #    WHEN substring(${cn_name},1, 2) = 'PA' THEN 'Priestriver-A'
    #    WHEN substring(${cn_name},1, 2) = 'RA' THEN 'Richmond-A'
    #    WHEN substring(${cn_name},1, 2) = 'RB' THEN 'Richmond-B'
    ##    WHEN substring(${cn_name},1, 2) = 'RC' THEN 'Richmond-C'
     #   WHEN substring(${cn_name},1, 2) = 'RM' THEN 'Mantis Shrimp MkII'
     #   WHEN substring(${cn_name},1, 2) = 'TC' THEN 'Tenderloin-C'
    #    ELSE 'PowerEdge R710/R510/Other' END ;;
  }

  dimension: ram_overhead {
    type: number
    sql: coalesce(${TABLE}."Overhead",0) ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: num_zones {
    type: number
    sql: coalesce(${TABLE}."Prov",0) ;;
  }
  dimension: rack_name {
    type: string
    sql: case
          when left(right((${rack_identifier}), 3), 1) = '-' then
                left((${rack_identifier}),-3)
                else
                left((${rack_identifier}),-2)
                end ;;
  }
   dimension: rack_identifier {
    type: string
    sql: ${TABLE}."rack identifier" ;;
  }

  dimension: cn_reserved {
    type: yesno
    sql: ${TABLE}."reserved" ;;
  }

  dimension: ram_sellable {
    type: number
    sql:coalesce( ${TABLE}."Sellable",0) ;;
  }

  dimension: serial_number {
    type: string
    sql: ${TABLE}."Serial Number" ;;
  }

  dimension: setup {
    type: yesno
    sql: ${TABLE}."Setup" ;;
  }

  dimension: sku_number {
    type: string
    sql: ${TABLE}."Sku Number" ;;
  }

  dimension: ram_sold {
    type: number
    sql: ${TABLE}."Sold" ;;
  }

  dimension: sold_percent {
    type: number
    sql: coalesce(${TABLE}."Sold%",0) ;;
  }

  dimension: traits {
    type: string
    sql: ${TABLE}."traits"::text ;;
  }
  dimension: ssd_node {
    type: yesno
    sql: ${TABLE}.traits ->> 'ssd' is not null;;

  }
  dimension: storage_node {
    type: yesno
    sql: ${TABLE}.traits ->> 'storage' is not null ;;
  }
  dimension: triton_node {
    type:  yesno
    sql: ${TABLE}.traits ->> 'triton' is not null ;;
  }
  dimension: internal_node {
    type: yesno
    sql: ${TABLE}.traits ->> 'internal' is not null ;;
  }
  dimension: manta_node {
    type:  yesno
    sql:   ${cn_model} = 'Manta Shrimp';;
  }
  dimension: manta_meta_node {
    type:  yesno
    sql: ${TABLE}.traits ->> 'triton' = 'manta' and ${cn_model} != 'Manta Shrimp' ;;
  }
  dimension: disk_unprovisioned {
    type: number
    sql: coalesce(${TABLE}."unprovisioned pool G",0) ;;
  }

  dimension: unprovisioned_ratio {
    type: number
    sql: coalesce(${TABLE}."unprovisioned ratio ",0) ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}."uuid";;
  }

  dimension: unreserved_cpu {
    type: number
    sql: coalesce( ${TABLE}.unreserved_cpu, 0) ;;
  }

  dimension: pool {
    description: "All unreserved CNs except internal or triton traited"
    type: yesno
    sql:   ${TABLE}.traits ->> 'internal' is  null and  ${TABLE}.traits ->> 'triton' is  null and ${TABLE}.traits ->> 'customers' is  null and NOT ${cn_reserved};;
  }
  dimension: isHeadnode {
    description: "Is this CN a headnode"
    type:  yesno
    sql:  ${cn_name} = 'headnode' OR ${cn_name} = 'HEADNODE' OR   ${TABLE}.traits ->> 'triton' = 'headnode' ;;
  }
  dimension: general_pool {
    description: "All CNs for public use sans ssd"
    type: yesno
    sql: ${pool} and  ${TABLE}.traits ->> 'ssd' is  null   ;;
  }
  dimension: general_ssd_pool {
    description: "All ssd CNs for public use"
    type: yesno
    sql: ${pool} and  ${TABLE}.traits ->> 'ssd' is  not null ;;
  }
  dimension: ssd_pool {
    description: "All ssd CNs"
    type: yesno
    sql:  ${TABLE}.traits ->> 'ssd' is  not null ;;
  }

  dimension: free_ram_tier {
    type: tier
    tiers: [16, 32,64,110, 220,440,512]
    sql:  ${unreserved_ram} / 1024 ;;
    style: integer
  }

  dimension: unreserved_disk {
    type: number
    sql: coalesce( ${TABLE}.unreserved_disk, 0) ;;
  }

  dimension: unreserved_ram {
    type: number
    sql: coalesce(${TABLE}.unreserved_ram,0) ;;
  }
  dimension:memory_total_bytes  {
  type:  number
  sql:  ${TABLE}.memory_total_bytes ;;
  }
dimension:disk_cores_quota_used_bytes  {
type:  number
sql:  ${TABLE}.disk_cores_quota_used_bytes ;;
}
dimension:disk_installed_images_used_bytes  {
type:  number
sql:  ${TABLE}.disk_installed_images_used_bytes ;;
}
dimension:disk_kvm_zvol_used_bytes  {
type:  number
sql:  ${TABLE}.disk_kvm_zvol_used_bytes ;;
}
dimension:disk_kvm_zvol_volsize_bytes  {
type:  number
sql:  ${TABLE}.disk_kvm_zvol_volsize_bytes ;;
}
dimension:disk_pool_alloc_bytes  {
type:  number
sql:  ${TABLE}.disk_pool_alloc_bytes ;;
}
dimension:disk_zone_quota_bytes  {
type:  number
sql:  ${TABLE}.disk_zone_quota_bytes ;;
}
dimension:ram_g  {
type:  number
sql:  ${TABLE}.ram_g ;;
}

  dimension: live_pi_bucket{
    type:  tier
    tiers: [20140101, 20150101, 20160101, 20170101, 20180101]
    sql:  ${live_pi_number} ;;
    style: integer
 }
  dimension: num_ram_slots  {
    type: number
    description: "number of package slots available"
    sql: least(floor( ${unreserved_ram} /  ${papi.max_physical_memory})::integer, floor(${unreserved_cpu} / ${papi.cpu_cap})::integer, floor(${unreserved_disk}/${papi.quota})::integer);;

  }
  dimension: ram_slots_available {
    type:  number
    sql: case when ${num_ram_slots} > 0 then ${num_ram_slots} else 0 END;;
  }
  dimension: isSuperMicro {
    type:  yesno
    sql:  case when substring(${serial_number},1, 1) = 'S' then true else false END ;;
  }

  dimension: shortName {
    type: string
    sql:  CASE
            WHEN ${traits} LIKE '%headnode%' THEN 'Headnode'
            WHEN ${cn_name} = 'headnode' THEN 'Headnode'
            WHEN ${cn_name} = 'HEADNODE' THEN 'Headnode'
            ELSE
              CASE
  WHEN ${sku_number} = '600-0023-001'  THEN 'Hallasan-A'
  WHEN ${sku_number} = 'SKU=NotProvided;ModelName=Joyent-Compute-Platform-3301' THEN 'Hallasan-A'
  WHEN ${sku_number} = '600-0024-001' THEN 'Hallasan-C (8)'
  WHEN ${sku_number} = '600-0026-001' THEN 'Hallasan-C (16)'
  WHEN ${sku_number} = '600-0025-001' THEN 'Mantis Shrimp Mk.III (8TB)'
  WHEN ${sku_number} = '600-0025-01 rev 50' THEN 'Mantis Shrimp Mk.III (8TB)'
  WHEN ${sku_number} = '600-0025-002' THEN 'Mantis Shrimp Mk.III (10TB)'
  WHEN ${sku_number} = '600-0025-01 rev 51' THEN 'Mantis Shrimp Mk.III (10TB)'
  WHEN ${sku_number} = '600-0028-001' THEN 'Hallasan-B'
  WHEN ${sku_number} = '600-0027-001' THEN 'Hallasan-A r2'
  WHEN ${sku_number} = '600-0027-01 rev 50' THEN 'Hallasan-A r2'
  WHEN ${sku_number} = '600-0032-001' THEN 'Jirisan-A'
  WHEN ${sku_number} = '600-0033-001' THEN 'Jirisan-B'
  WHEN ${sku_number} = '600-0034-001' THEN 'Jirisan-C (12)'
  WHEN ${sku_number} = '600-0035-001' THEN 'Jirisan-C (24)'
  WHEN ${sku_number} = '600-0036-001' THEN 'Mantis Shrimp Mk.III.5 (12TB)'
  WHEN ${sku_number} = 'SKU=NotProvided;ModelName=Joyent-Compute-Platform-3302' THEN 'Hallasan-C'
  WHEN ${sku_number} = '085915D9' THEN 'Hallasan-A r2'
                ELSE ${sku_number}
              END
            END;;
  }

  measure: count {
    type: count
    drill_fields: [cn_name]
  }
  measure: count_product{
    type:  count
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: ram_total_t {
    type: sum
    sql:  (${memory_total_bytes} - ${ram_overhead})  / 1024 / 1024 / 1024 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_free_total_t {
    type:  sum
    sql: ${unreserved_ram} / 1024  ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_total_g {
    type: sum
    sql:  (${memory_total_bytes} - ${ram_overhead}) / 1024 / 1024 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_free_total_g {
    type:  sum
    sql:  ${unreserved_ram}  ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: disk_pool_total_t {
    type:  sum
    sql:  ${disk_pool}::int / 1024 / 1024 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: disk_unprovisioned_total_t {
    type:  sum
    sql:  ${disk_unprovisioned} / 1024 / 1024 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: ram_sold_total_t {
    type: sum
    sql: (${memory_total_bytes} - ${ram_overhead}) / 1024 / 1024 / 1024 - ${unreserved_ram}/1024;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: total_num_zones {
    type:  sum
    sql: ${num_zones} ;;
  }
  measure: total_num_cns {
    type: count_distinct
    sql: ${cn_name} ;;
  }
  measure: unreserved_ram_g {
    type:  sum
    sql: ${unreserved_ram} ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }

  measure: unreserved_disk_g {
    type:  sum
    sql: ${unreserved_disk} / 1024 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: unreserved_ram_t {
    type:  sum
    sql: ${unreserved_ram} / 1024  ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }

  measure: unreserved_disk_t {
    type:  sum
    sql: ${unreserved_disk} / 1024 / 1024 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }

  measure: avg_num_zones {
    type: average
    sql: ${num_zones} ;;
  }

measure: count_manta_meta {
  type: sum
  sql:  ${manta_meta_node}::int ;;
}
  measure: count_manta {
    type: sum
    sql:  ${manta_node}::int ;;
  }
  measure: count_general_ssd_pool {
    type:  sum
    sql:  ${general_ssd_pool}::int ;;
  }
  measure: count_general_pool {
    type:  sum
    sql:  ${general_pool}::int ;;
  }
  measure: count_setup {
    type:  sum
    sql:  ${setup}::int ;;
  }
  measure: count_not_setup {
    type:  sum
    sql:  CASE WHEN ${setup} THEN 0 ELSE 1 END ;;
  }
  measure: count_internal {
    type: sum
    sql: ${internal_node}::int ;;
  }
  measure: count_headnode {
    type:  sum
    sql: ${isHeadnode}::int;;
  }
  measure: sum_package_slots_available {
    type:  sum
    sql: ${ram_slots_available};;
  }

}

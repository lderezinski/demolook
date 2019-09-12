# include: "values.view.lkml"

view: cnapi {

  sql_table_name: smartdc.cnapi ;;

  dimension: compound_primary_key {
    description: "primary key date + dcenter + hostname"
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."DATE"  || ${TABLE}."DCENTER" || ${TABLE}."HOSTNAME";;
  }

  parameter: input_value {
    description: "parameter validates instance ram size"
    type: number
    suggest_explore: ram_values
    suggest_dimension: papi.max_physical_memory
  }

 parameter: disk_footprint {
   description: "parameter Amount of Disk in G"
  type:  number
 }
parameter: cpu {
  description: "parameter dedicated CPU"
  type: number
}

  dimension: boot_platform {
    description:"CNapi boot_platform"
    type: string
    sql: ${TABLE}."boot platform" ;;
  }
  dimension_group: boot_pi_date {
    description:"date parsed out of CNapi boot_platform"
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
    description:"CNapi sysinfo Live Image"
    type: string
    sql: ${TABLE}."live image" ;;
  }
  dimension_group: live_pi_date {
    description:"date parsed out of CNapi sysinfo Live Image"
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
    description:"PI number parsed out of CNapi sysinfo Live Image"
    type:  number
    sql: to_number(substring(${live_image},1,8),'99999999') ;;
  }

  dimension: months_since_pi{
    description:"Number of months since the live PI was released"
    type: number
    sql: (DATE_PART('year', NOW()) - ${live_pi_date_year})*12 + DATE_PART('month', NOW()) - DATE_PART('month',${live_pi_date_date});;
  }

  dimension: months_pi_tier{
    description:"Number of months grouped into 0,1,3,6,12,24,36,48+ since the live PI was released"
    type: tier
    tiers: [0,1,3,6,12,24, 36,48]
    sql: ${months_since_pi};;
  }

  dimension: cores {
    description:"CNapi sysinfo CPU Total Cores"
    type: number
    sql: coalesce( ${TABLE}."Cores",0) ;;
  }

  dimension: cpu_cores {
    description:"CNapi sysinfo CPU Total Cores"
    type: number
    sql: coalesce(${TABLE}.cpu_cores,0) ;;
  }

  dimension_group: created {
    description:"CNapi created timestamp"
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
    description:"Timestamp when Cnapi data was collected"
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

  measure: last_reported_date {
    description:"The most recient date of the data"
    type: date
    sql: MAX(${date_raw}) ;;
    convert_tz: no
  }
  measure: first_reported_date {
    description:"The oldest date of the data"
    type: date
    sql: MIN(${date_raw}) ;;
    convert_tz: no
  }
  dimension: is_last_day_of_month{
    description:"Is the date of data on the last day of the month"
    type: yesno
    sql: (date_trunc('MONTH', ${date_date}) + INTERVAL '1 MONTH - 1 day')::date = ${date_date};;
  }

  dimension: dc {
    description:"CNapi datacenter"
    type: string
    sql: ${TABLE}."DCENTER" ;;
  }

  dimension: disk_pool {
    description:"CNapi.disk_pool_size_bytes converted to GB"
    type: number
    sql: coalesce(${TABLE}."disk pool size G",0)/1024.0 ;;
  }
  dimension: disk_pool_t {
    description:"CNapi.disk_pool_size_bytes converted to TB"
    type:  number
    sql:  ${disk_pool} / 1024.0 ;;
    value_format_name: decimal_2
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }

  dimension: disk_pool_tier {
    description:"CNapi.disk_pool_size_bytes converted to TB in tiers of 0,100,150,200,250,300,350+"
    type:  tier
    tiers: [0,100,150,200,250,300,350]
    sql:  ${disk_pool_t} ;;
    style: integer
  }
  dimension: ram_free {
    description: "CNapi.memory_available_bytes converted to MB"
    type: number
    sql: coalesce(${TABLE}."Free",0) ;;
    value_format_name: decimal_0
  }

  dimension: cn_name {
    description:"CNapi.hostname"
    type: string
    sql: upper(${TABLE}."HOSTNAME") ;;
  }
  dimension: role {
    description:"CNapi.traits grouping them into Headnode, Manta, bhyve or Compute"
    type: string
    sql:  CASE
            WHEN ${traits} LIKE '%headnode%' THEN 'Headnode'
            WHEN upper(${cn_name}) = 'HEADNODE' THEN 'Headnode'
            ELSE
              CASE
                WHEN ${traits} LIKE '%manta%'  THEN 'Manta'
                WHEN ${traits} LIKE '%bhyve_true%' THEN 'bhyve'
                ELSE 'Compute'
              END
            END;;
  }
  dimension: hwfamily {
    description:"CNapi.HWFamily"
    type: string
    sql: ${TABLE}."HWFamily" ;;
  }

  dimension: hwversion {
    description:"CNapi.HWversion"
    type: string
    sql: ${TABLE}."HWversion" ;;
  }

  dimension: joy_num {
    description:"total number of joyent vms listed in CNapi.vms"
    type: number
    sql: coalesce(${TABLE}."joyent",0) ;;
  }

  dimension: joyent_percent {
    description:"total percent of joyent vms listed in CNapi.vms"
    type: number
    sql: coalesce( ${TABLE}."%joyent",0) ;;
  }

  dimension: kvm_num {
    description:"total number of kvm vms listed in CNapi.vms"
    type: number
    sql:coalesce( ${TABLE}."kvm",0) ;;
  }

  dimension: kvm_percent {
    description:"total percent of kvm vms listed in CNapi.vms"
    type: number
    sql:coalesce( ${TABLE}."%kvm",0) ;;
  }

  dimension_group: last_boot {
    description:"CNapi.last_boot timestamp of the last boot for the CN"
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
    description:"total number of lx vms listed in CNapi.vms"
    type: number
    sql: ${TABLE}."lx" ;;
  }

  dimension: lx_percent {
    description:"total percent of lx vms listed in CNapi.vms"
    type: number
    sql: coalesce( ${TABLE}."%lx", 0) ;;
  }

  dimension: cn_minimal {
    description:"total number of minimal vms listed in CNapi.vms"
    type: number
    sql: coalesce(${TABLE}."minimal",0) ;;
  }

  dimension: minimal_percent {
    description:"total percent of minimal vms listed in CNapi.vms"
    type: number
    sql:coalesce( ${TABLE}."%minimal",0) ;;
  }
  dimension: trait_types {
    description: "JSON CNapi.traits"
    type:  string
    sql:  json_object_keys(${TABLE}.traits) ;;
  }

  # https://github.com/joyent/opstools/blob/master/src/bin/ops-cnsetup#L354-L430
  dimension: cn_model {
    description:"Derived from CNapi.hostname, CNapi.sysinfo['SKU Number']"
    type: string
     sql: ${TABLE}."Model" ;;
  }

  dimension: ram_overhead {
    description: "((CNapi.memory_total_bytes/1024.0) - (CNapi.memory_provisionable_bytes/1024.0)) * 1024 || 0"
    # this is in MB
    type: number
    sql: coalesce(${TABLE}."Overhead",0) ;;
    value_format_name:  decimal_0
  }

  dimension: product_name {
    description: "CNapi.sysinfo.Product"
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: num_zones {
    description: "CNapi.vms.length"
    type: number
    sql: coalesce(${TABLE}."Prov",0) ;;
  }
  dimension: rack_name {
    description: "parsed out of CNapi.rack_identifier, the slot number is removed"
    type: string
    sql: case
          when left(right((${rack_identifier}), 3), 1) = '-' then
                left((${rack_identifier}),-3)
                else
                left((${rack_identifier}),-2)
                end ;;
  }
   dimension: rack_identifier {
    description: "CNapi.rack_identifier"
    type: string
    sql: ${TABLE}."rack identifier" ;;
  }

  dimension: cn_reserved {
    description: "CNapi.reserved"
    type: yesno
    sql: ${TABLE}."reserved" ;;
  }

  dimension: ram_sellable {
    description: "CNapi.memory_provisionable_bytes"
    type: number
    sql:coalesce( ${TABLE}."Sellable",0) ;;
    value_format_name:  decimal_2
  }

  dimension: serial_number {
    description: "CNapi.sysinfo['Serial Number']"
    type: string
    sql: ${TABLE}."Serial Number" ;;
  }
  dimension: manufacture {
    description: "CNapi.sysinfo.Manufacturer"
    type: string
    sql: CASE
           WHEN length(${TABLE}.manufacturer) > 4 THEN ${TABLE}.manufacturer
           WHEN length(${serial_number}) = 7 THEN 'DELL'
           WHEN length(${serial_number}) >= 13 and length(${serial_number}) <= 15 THEN 'SMCI'
           WHEN ${serial_number} = '0123456789' and left(upper(${cn_name}),2) = 'RA' THEN 'SMCI'
           ELSE 'Unknown'
          END;;
  }
  dimension: setup {
    description: "CNapi.sysinfo.Setup"
    type: yesno
    sql: ${TABLE}."Setup" ;;
  }

  dimension: sku_number {
    description: "CNapi.sysinfo['SKU Number']"
    type: string
    sql: ${TABLE}."Sku Number" ;;
  }

dimension: ram_sold {
  description: "(CNapi.memory_provisionable_bytes) - (CNapi.memory_available_bytes)  || 0; converted to MB"
    type: number
    sql: ${TABLE}."Sold" ;;
    value_format_name:  decimal_2
  }

  dimension: sold_percent {
    description: "ram_sold / CNapi.memory_provisionable_bytes"
    type: number
    sql: coalesce(${TABLE}."Sold%",0) ;;
  }

  dimension: traits {
    description: "CNapi.traits"
    type: string
    sql: ${TABLE}."traits"::text ;;
  }
  dimension: qa_node {
    description: "Does CNapi.traits contain qa?"
    type: yesno
    sql: ${TABLE}.traits ->> 'qa' is not null;;

  }

  dimension: ssd_node {
    description: "Does CNapi.traits contain ssd?"
    type: yesno
    sql: ${TABLE}.traits ->> 'ssd' is not null;;

  }

  dimension: storage_node {
    description: "Does CNapi.traits contain storage?"
    type: yesno
    sql: ${TABLE}.traits ->> 'storage' is not null ;;
  }

  dimension: triton_node {
    description: "Does CNapi.traits contain triton?"
    type:  yesno
    sql: ${TABLE}.traits ->> 'triton' is not null ;;
  }

  dimension: triton_manta_node {
    description: "Does CNapi.traits contain manta?"
    type:  yesno
    sql: ${TABLE}.traits ->> 'triton' = 'manta' ;;
  }

  dimension: internal_node {
    description: "Does CNapi.traits contain internal?"
    type: yesno
    sql: ${TABLE}.traits ->> 'internal' is not null ;;
  }

  dimension: manta_node {
    description: "cn_model LIKE '%Shrimp%'"
    type:  yesno
    sql:   ${cn_model} LIKE '%Shrimp%';;
  }
  dimension: manta_meta_node {
    description: "CNapi.traits contains triton=manta and the cn_model doesn't contain Shrimp"
    type:  yesno
    sql: ${TABLE}.traits ->> 'triton' = 'manta' and NOT ${cn_model} LIKE '%Shrimp%' ;;
  }
  dimension: disk_unprovisioned {
    description: "CNapi.disk_pool_size_bytes - CNapi.disk_kvm_zvol_volsize_bytes - CNapi.disk_zone_quota_bytes - CNapi.disk_cores_quota_used_bytes - CNapi.disk_installed_images_used_bytes - (count of CNapi.vms that are kvm) * 10 * GB;"
    type: number
    sql: coalesce(${TABLE}."unprovisioned pool G",0) ;;
  }

  dimension: unprovisioned_ratio {
    description: "unprovisioned_pool / CNapi.disk_pool_size_bytes"
    type: number
    sql: coalesce(${TABLE}."unprovisioned ratio ",0) ;;
  }

  dimension: uuid {
    description: "CNapi.uuid the uuid for the CN"
    type: string
    sql: ${TABLE}."uuid";;
  }

  dimension: unreserved_cpu {
    description: "CNapi.unreserved_cpu"
    type: number
    sql: coalesce( ${TABLE}.unreserved_cpu, 0) ;;
  }

  dimension: pool {
    description: "Is this a Compute CN, is CNapi.role == Compute"
    type: yesno
    sql:   ${role} = 'Compute';;
  }

  dimension: isHeadnode {
    description: "Is this CN a headnode does CNapi.model == 'Headnode'"
    type:  yesno
    sql:  upper(${cn_model}) = 'HEADNODE' ;;
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
    description: "CNapi.unreserved_ram in G tiers 16,32,64,110,229,440,512+"
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
    # MB
    description: "CNapi.unreserved_ram in MB"
    type: number
    sql: coalesce(${TABLE}.unreserved_ram,0) ;;
    value_format_name:  decimal_0
  }

  dimension:memory_total_bytes  {
    description: "CNapi.memory_total_bytes"
    # bytes
    type:  number
    sql:  ${TABLE}.memory_total_bytes ;;
  }

  dimension:disk_cores_quota_used_bytes  {
    description: "CNapi.disk_cores_used_bytes"
    type:  number
    sql:  ${TABLE}.disk_cores_quota_used_bytes ;;
  }

  dimension:disk_installed_images_used_bytes  {
    description: "CNapi.disk_installed_images_used_bytes"
    type:  number
    sql:  ${TABLE}.disk_installed_images_used_bytes ;;
  }

  dimension:disk_kvm_zvol_used_bytes  {
    description: ""
    type:  number
    sql:  ${TABLE}.disk_kvm_zvol_used_bytes ;;
  }

  dimension:disk_kvm_zvol_volsize_bytes  {
    description: "CNapi.disk_kvm_zvol_used_bytes"
    type:  number
    sql:  ${TABLE}.disk_kvm_zvol_volsize_bytes ;;
  }

  dimension:disk_pool_alloc_bytes  {
    description: "CNapi.disk_pool_alloc_bytes"
    type:  number
    sql:  ${TABLE}.disk_pool_alloc_bytes ;;
  }

  dimension:disk_zone_quota_bytes  {
    description: "CNapi.disk_zone_quota_bytes"
    type:  number
    sql:  ${TABLE}.disk_zone_quota_bytes ;;
  }

  dimension:ram_g  {
  # This is really in MB not GB as the column name suggests, so lets make it be GB
  description: "CNapi.ram_g "
    type:  number
    sql:  ${TABLE}.ram_g / 1024.0;;
    value_format_name:  decimal_0
}

  dimension: live_pi_bucket{
    description: "Extracted from CNapi.liveImage"
    type:  tier
    tiers: [20140101, 20150101, 20160101, 20170101, 20180101, 20190101]
    sql:  ${live_pi_number} ;;
    style: integer
 }
  dimension: num_ram_slots  {
    type: number
    description: "number of package slots available"
    sql: least(floor( ${unreserved_ram} /  ${papi.max_physical_memory})::integer, floor(${unreserved_cpu} / ${papi.cpu_cap})::integer, floor(${unreserved_disk}/${papi.quota})::integer);;

  }
  dimension: ram_slots_available {
    description: "num_ram_slots or 0"
    type:  number
    sql: case when ${num_ram_slots} > 0 then ${num_ram_slots} else 0 END;;
  }
  dimension: isSuperMicro {
    description: "Is this CN from super Micro? CNapi.serial_number[0] == 'S'"
    type:  yesno
    sql:  case when substring(${serial_number},1, 1) = 'S' then true else false END ;;
  }

  dimension: shortName {
    description: "derived from CNapi.traits, CNapi.name, CNapi.sku_number"
    type: string
    sql:  CASE
            WHEN ${traits} LIKE '%headnode%' THEN 'Headnode'
            WHEN upper(${cn_name}) = 'HEADNODE' THEN 'Headnode'
            WHEN left(${cn_name},2) = 'HB' THEN
              case WHEN ${sku_number} = '600-0025-01 rev 50' THEN 'Hallasan-B (08TB)'
                   WHEN ${sku_number} = '600-0025-01 rev 51' THEN 'Hallasan-B (10TB)'
                   WHEN ${sku_number} = '600-0036-001' THEN 'Hallasan-B (12TB)'
                  ELSE ${sku_number}
              END
  WHEN ${sku_number} = '600-0023-001'  THEN 'Hallasan-A'
  WHEN ${sku_number} = 'SKU=NotProvided;ModelName=Joyent-Compute-Platform-3301' THEN 'Hallasan-A'
  WHEN ${sku_number} = '600-0024-001' THEN 'Hallasan-C (08)'
  WHEN ${sku_number} = '600-0026-001' THEN 'Hallasan-C (16)'
  WHEN ${sku_number} = '600-0025-001' THEN 'Mantis Shrimp Mk.III (08TB)'
  WHEN ${sku_number} = '600-0025-01 rev 50' THEN 'Mantis Shrimp Mk.III (08TB)'
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
  WHEN ${sku_number} = 'SKU=NotProvided;ModelName=Joyent-Compute-Platform-3302' THEN
    case
      WHEN ${disk_pool} < 10790592 THEN 'Hallasan-C (08)'
      ELSE 'Hallasan-C (16)' END
  WHEN ${sku_number} = '085915D9' THEN
     case WHEN left(${cn_name},2) = 'HA' THEN 'Hallasan-A r2'
          WHEN left(${cn_name},2) = 'MS' THEN 'Mantis Shrimp Mk.III (10TB)'
          ELSE ${sku_number}
     END
  ELSE ${sku_number}

            END;;
  }


  measure: count {
    description: "Count of CNapi objects"
    type: count
    drill_fields: [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: count_product{
    description: "Count of CNapi objects"
    type:  count
    drill_fields: [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: ram_total_t {
    description: "CNapi.memory_total_bytes - ram_overhead converted to TB"
    type: sum
    sql:  (${memory_total_bytes}/1024.0/1024.0 - ${ram_overhead})  / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
    drill_fields: [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: ram_free_total_t {
    description: "CNapi.unreserved_ram converted to TB"
    type:  sum
    sql: ${unreserved_ram} / 1024.0 /1024.0;;
    value_format_name:  decimal_2
    drill_fields: [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: ram_total_g {
    description: "CNapi.memory_total_bytes - Cnapi.ram_overhead converted to GB"
    type: sum
    sql:  (${memory_total_bytes}/1024.0/1024.0 - ${ram_overhead})  / 1024.0 ;;
    value_format_name: decimal_2
    drill_fields: [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: ram_free_total_g {
    description: "unreserved_ram converted to GB"
    type:  sum
    sql:  ${unreserved_ram} / 1024.0 ;;
    value_format_name:  decimal_2
    drill_fields: [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: disk_pool_total_t {
    description: "disk_pool converted to TB"
    type:  sum
    sql:  ${disk_pool} / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
    drill_fields: [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: disk_unprovisioned_total_t {
    description: "disk_unprovisioned converted to TB"
    type:  sum
    sql:  ${disk_unprovisioned} / 1024.0 / 1024.0 ;;
    value_format_name: decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: ram_sold_total_g {
    description: "CNapi.ram - CNapi.unreserved_ram converted to G"
    type: sum
     # Note table.ram_g is really in MB ${ram_g} is in Gig
    sql: ((${TABLE}.ram_g) - ${unreserved_ram}) / 1024.0 ;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: ram_sold_total_t {
    type: sum
      # Note table.ram_g is really in MB ${ram_g} is in Gig
      description: "CNapi.ram - CNapi.unreserved_ram converted to TB"
    sql: ((${TABLE}.ram_g) - ${unreserved_ram}) / 1024.0 / 1024.0 ;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: ram_overhead_g{
    description: "ram_overhead converted to GB"
    type: sum
    sql: ( ${ram_overhead} / 1024.0 ) ;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: ram_overhead_t{
    description: "ram_overhead converted to TB"
    type: sum
    sql: ( ${ram_overhead} / 1024.0 /1024.0) ;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: total_num_zones {
    description: "sum of num_zones"
    type:  sum
    sql: ${num_zones} ;;
  }

  measure: total_num_cns {
    description: "count distinct CNapi.name"
    type: count_distinct
    sql: ${cn_name} ;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: unreserved_ram_g {
    description: "CNapi.unreserved_ram in G"
    type:  sum
    sql: ${unreserved_ram} / 1024.0;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: unreserved_disk_g {
    description: "CNapi.unreserved_disk converted to GB"
    type:  sum
    sql: ${unreserved_disk} / 1024.0 ;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: unreserved_ram_t {
    description: "CNapi.unreserved_ram converted to TB"
    type:  sum
    sql: ${unreserved_ram} / 1024.0 / 1024.0 ;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: unreserved_disk_t {
    description: "CNapi.unreserved_disk converted to TB"
    type:  sum
    sql: ${unreserved_disk} / 1024.0 / 1024.0 ;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: avg_num_zones {
    description: "the average number of zones from CNapi.vms count"
    type: average
    sql: ${num_zones} ;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

measure: count_manta_meta {
  description: "summation of the number of manta_meta_node CNs"
  type: sum
  sql:  ${manta_meta_node}::int ;;
  drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
}

  measure: count_manta {
    description: "summation of the number of manta CNs"
    type: sum
    sql:  ${manta_node}::int ;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: count_general_ssd_pool {
    description: "Summation of the number of general ssd CNs"
    type:  sum
    sql:  ${general_ssd_pool}::int ;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: count_general_pool {
    description: "Summation of the number of general_pool CNs"
    type:  sum
    sql:  ${general_pool}::int ;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: count_setup {
    description: "Summation of the number of CNs which are setup"
    type:  sum
    sql:  ${setup}::int ;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: count_not_setup {
    description: "Summation of the number of CNs which are not setup"
    type:  sum
    sql:  CASE WHEN ${setup} THEN 0 ELSE 1 END ;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: count_internal {
    description: "Summation of the number of CNs which are traited internal"
    type: sum
    sql: ${internal_node}::int ;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: count_headnode {
    description: "Summation of the number of CNs which are headnode"
    type:  sum
    sql: ${isHeadnode}::int;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: sum_package_slots_available {
    description: "Summation of the number package slots available."
    type:  sum
    sql: ${ram_slots_available};;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: count_distinct {
    description: "The Number distinct CNs"
    type: count_distinct
    sql: ${uuid} ;;
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure:physical_ram_g  {
    description: "Summation of the ram in G"
    type:  sum
    sql:  ${ram_g};;
    value_format_name:  decimal_0
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure:physical_ram_t  {
    description: "Summation of the ram in T"
    type:  sum
    sql:  ${TABLE}.ram_g / 1024.0 / 1024.0;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure:mem_total_ram_mb  {
    description: "Summation of the total ram converted to MB"
    type:  sum
    sql:  ${memory_total_bytes}/1024.0/1024.0 ;;
    value_format_name:  decimal_2
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: disk_pool_alloc_t {
    description: "Summation CNapi.disk_pool_alloc_bytes converted to TB"
    type: sum
    sql: ${disk_pool_alloc_bytes}/ 1024.0 / 1024.0/ 1024.0 / 1024.0;;
    value_format_name: decimal_3
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }

  measure: disk_pool_free_t {
    description: "CNapi.disk_pool - CNapi.disk_pool_alloc_bytes - CNapi.disk_pool*0.05 converted to TB"
    type: sum
    sql:  (${disk_pool} - ${disk_pool_alloc_bytes}/ 1024.0 / 1024.0 - ${disk_pool}* 0.05) / 1024.0 / 1024.0 ;;
    value_format_name: decimal_3
    drill_fields:  [cn_name,serial_number,shortName, dc,rack_name,ram_sellable]
  }
}

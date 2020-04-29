view: cnapimonthly {
  sql_table_name: smartdc.cnapimonthly ;;

  dimension: boot_platform {
    description:"CNapi boot_platform"
    type: string
    sql: ${TABLE}.boot_platform ;;
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
    sql:CASE WHEN ${boot_platform} = 'pmooneydev' THEN NULL
             WHEN ${boot_platform} = 'imc-rm' THEN NULL
            ELSE to_date(substring(${boot_platform},1,8),'YYYYMMDD')
        END ;;
    datatype: date
  }

  dimension: live_image {
    description:"CNapi sysinfo Live Image"
    type: string
    sql: ${TABLE}.live_image ;;
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
  dimension: months_since_pi{
    description:"Number of months since the live PI was released"
  type: number
    sql:datediff(month,  ${live_pi_date_date}, CURRENT_DATE()) ;;
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
    sql: ${TABLE}.Cores ;;
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
      quarter,
      year
    ]
    sql: ${TABLE}.DATE ;;
  }

  dimension: dc {
    description:"CNapi datacenter"
    type: string
    sql: ${TABLE}.DCENTER ;;
  }

  dimension: disk_pool {
    description:"CNapi.disk_pool_size_bytes converted to GiB"
    type: number
    sql: ${TABLE}.disk_pool_size_G ;;
  }

  dimension: ram_free {
    description: "CNapi.memory_available_bytes converted to MiB"
    type: number
    sql: ${TABLE}.Free ;;
  }

  dimension: cn_name {
    description:"CNapi.hostname"
    type: string
    sql: ${TABLE}.HOSTNAME ;;
  }

  dimension: joy_num {
    description:"total number of joyent vms listed in CNapi.vms"
    type: number
    sql: ${TABLE}.joyent ;;
  }

  dimension: joyent_percent {
    description:"total percent of joyent vms listed in CNapi.vms"
    type: number
    sql: ${TABLE}.joyent_percent ;;
  }

  dimension: kvm_num {
    description:"total number of kvm vms listed in CNapi.vms"
    type: number
    sql: ${TABLE}.kvm ;;
  }

  dimension: kvm_percent {
    description:"total percent of kvm vms listed in CNapi.vms"
    type: number
    sql: ${TABLE}.kvm_percent ;;
  }

  dimension: num_lx {
    description:"total number of lx vms listed in CNapi.vms"
    type: number
    sql: ${TABLE}.lx ;;
  }

  dimension: lx_percent {
    description:"total percent of lx vms listed in CNapi.vms"
    type: number
    sql: ${TABLE}.lx_percent ;;
  }

  dimension: cn_minimal {
    description:"total number of minimal vms listed in CNapi.vms"
    type: number
    sql: ${TABLE}.minimal ;;
  }

  dimension: minimal_percent {
    description:"total percent of minimal vms listed in CNapi.vms"
    type: number
    sql: ${TABLE}.minimal_percent ;;
  }

  #LSDLSDLSD broken trait_types
  dimension: trait_types {
    description: "JSON CNapi.traits"
    type:  string
    sql:  ${TABLE}.traits ;;
  }
  dimension: cn_model {
    description:"Derived from CNapi.hostname, CNapi.sysinfo['SKU Number']"
    type: string
    sql: ${TABLE}.Model ;;
  }

  dimension: ram_overhead {
    description: "((CNapi.memory_total_bytes/1024.0) - (CNapi.memory_provisionable_bytes/1024.0)) * 1024 || 0"
    type: number
    sql: ${TABLE}.Overhead ;;
  }

  dimension: product_name {
    description: "CNapi.sysinfo.Product"
    type: string
    sql: ${TABLE}.Product ;;
  }

  dimension: num_zones {
    description: "CNapi.vms.length"
    type: number
    sql: ${TABLE}.Prov ;;
  }

  dimension: rack_identifier {
    description: "CNapi.rack_identifier"
    type: string
    sql: ${TABLE}.rack_identifier ;;
  }

  dimension: cn_reserved {
    description: "CNapi.reserved"
    type: yesno
    sql: ${TABLE}.reserved ;;
  }

  dimension: ram_sellable {
    description: "CNapi.memory_provisionable_bytes"
    type: number
    sql: ${TABLE}.Sellable ;;
  }

  dimension: serial_number {
    description: "CNapi.sysinfo['Serial Number']"
    type: string
    sql: ${TABLE}.Serial_Number ;;
  }

  dimension: setup {
    description: "CNapi.sysinfo.Setup"
    type: yesno
    sql: ${TABLE}.Setup ;;
  }

  dimension: sku_number {
    description: "CNapi.sysinfo['SKU Number']"
    type: string
    sql: ${TABLE}.Sku_Number ;;
  }

  dimension: ram_sold {
    description: "(CNapi.memory_provisionable_bytes) - (CNapi.memory_available_bytes)  || 0; converted to MiB"
    type: number
    sql: ${TABLE}.Sold ;;
  }

  dimension: sold_percent {
    description: "ram_sold / CNapi.memory_provisionable_bytes"
    type: number
    sql: ${TABLE}.Sold_percent ;;
  }

  dimension: traits {
    description: "CNapi.traits"
    type: string
    sql: ${TABLE}.traits ;;
  }
  dimension: ssd_node {
    description: "Does CNapi.traits contain ssd?"
    type: yesno
    sql: ${TABLE}.traits:ssd is not null ;;

  }
  dimension: internal_node {
    description: "Does CNapi.traits contain internal?"
    type: yesno
    sql: ${TABLE}.traits:internal is not null ;;

  }
  dimension: manta_node {
    description: "cn_model LIKE '%Shrimp%'"
    type:  yesno
    sql:  ${TABLE}.traits:internal is not null and ${TABLE}.traits:internal = 'Manta Node' ;;
  }

  dimension: disk_unprovisioned {
    description: "CNapi.disk_pool_size_bytes - CNapi.disk_kvm_zvol_volsize_bytes - CNapi.disk_zone_quota_bytes - CNapi.disk_cores_quota_used_bytes - CNapi.disk_installed_images_used_bytes - (count of CNapi.vms that are kvm) * 10 * GiB;"
    type: number
    sql: ${TABLE}.unprovisioned_pool_G ;;
  }

  dimension: unprovisioned_ratio {
    description: "unprovisioned_pool / CNapi.disk_pool_size_bytes"
    type: number
    sql: ${TABLE}.unprovisioned_ratio ;;
  }

  dimension: uuid {
    description: "CNapi.uuid the uuid for the CN"
    type: string
    sql: ${TABLE}.uuid;;
  }
  dimension: pool {
    description: "Is this a Compute CN, is CNapi.role == Compute"
    type: yesno
    sql: ${cn_name} != 'headnode' and  ${TABLE}.traits:triton is  null  and  ${TABLE}.traits:internal is  null  ;;
  }
  dimension: general_pool {
    description: "All CNs for public use sans ssd"
    type: yesno
    sql: ${cn_name} != 'headnode' and  ${TABLE}.traits:internal is  null and  ${TABLE}.traits:ssd is  null and  ${TABLE}.traits:customer is  null and  ${TABLE}.traits:storage is  null and ${TABLE}.reserved != 'f'  ;;
  }
  dimension: general_ssd_pool {
    description: "All ssd CNs for public use"
    type: yesno
    sql:  ${TABLE}.traits:ssd is  not null and  ${TABLE}.traits:customer is  null and  ${TABLE}.traits:storage is  null and ${TABLE}.reserved = 'f'  ;;
  }
  dimension: ssd_pool {
    description: "All ssd CNs"
    type: yesno
    sql:  ${TABLE}.traits:ssd is  not null ;;
  }

  dimension: free_ram_tier {
    description: "CNapi.unreserved_ram in G tiers 16,32,64,110,229,440,512+"
    type: tier
    tiers: [16, 32,64,110, 220]
    sql:  ${ram_free}/1024 ;;
    style: integer
  }
  measure: count {
    description: "Count of CNapi objects"
    type: count
    drill_fields: [cn_name]
  }
  measure: count_product{
    description: "Count of CNapi objects"
    type:  count
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: ram_total_t {
    description: "CNapi.memory_total_bytes - ram_overhead converted to TiB"
    type: sum
    sql:  ${ram_sellable}/1024.0/1024.0 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_free_total_t {
    description: "CNapi.unreserved_ram converted to TiB"
    type:  sum
    sql: ${ram_free}/1024.0/1024.0 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_total_g {
    description: "CNapi.memory_total_bytes - Cnapi.ram_overhead converted to GiB"
    type: sum
    sql:  ${ram_sellable}/1024.0 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_free_total_g {
    description: "unreserved_ram converted to GiB"
    type:  sum
    sql: ${ram_free}/1024.0 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: disk_pool_total_t {
    description: "disk_pool converted to TiB"
    type:  sum
    sql:  ${disk_pool}/1024.0/1024.0 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: disk_unprovisioned_total_t {
    description: "disk_unprovisioned converted to TiB"
    type:  sum
    sql:  ${disk_unprovisioned}/1024.0/1024.0 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: ram_sold_total_t {
    description: "CNapi.ram - CNapi.unreserved_ram converted to TiB"
    type: sum
    sql: ${ram_sold}/1024.0/1024.0 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
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
  }
  measure: avg_num_zones {
    description: "the average number of zones from CNapi.vms count"
    type: average
    sql: ${num_zones} ;;
  }


}

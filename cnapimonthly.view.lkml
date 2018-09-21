view: cnapimonthly {
  sql_table_name: smartdc.cnapimonthly ;;

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
  dimension: months_since_pi{
  type: number
  sql: DATEDIFF('month',NOW(), ${live_pi_date_month});;
}
 dimension: months_pi_tier{
  type: tier
  tiers: [0,1,3,6,12,24, 36,48]
  sql: ${months_since_pi}
}

  dimension: cores {
    type: number
    sql: ${TABLE}."Cores" ;;
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
    sql: ${TABLE}."DATE" ;;
  }

  dimension: dc {
    type: string
    sql: ${TABLE}."DCENTER" ;;
  }

  dimension: disk_pool {
    type: number
    sql: ${TABLE}."disk pool size G" ;;
  }

  dimension: ram_free {
    type: number
    sql: ${TABLE}."Free" ;;
  }

  dimension: cn_name {
    type: string
    sql: ${TABLE}."HOSTNAME" ;;
  }

  dimension: joy_num {
    type: number
    sql: ${TABLE}."joyent" ;;
  }

  dimension: joyent_percent {
    type: number
    sql: ${TABLE}."%joyent" ;;
  }

  dimension: kvm_num {
    type: number
    sql: ${TABLE}."kvm" ;;
  }

  dimension: kvm_percent {
    type: number
    sql: ${TABLE}."%kvm" ;;
  }

  dimension: num_lx {
    type: number
    sql: ${TABLE}."lx" ;;
  }

  dimension: lx_percent {
    type: number
    sql: ${TABLE}."%lx" ;;
  }

  dimension: cn_minimal {
    type: number
    sql: ${TABLE}."minimal" ;;
  }

  dimension: minimal_percent {
    type: number
    sql: ${TABLE}."%minimal" ;;
  }
  dimension: trait_types {
    type:  string
    sql:  json_object_keys(${TABLE}.traits) ;;
  }
  dimension: cn_model {
    type: string
    sql: ${TABLE}."Model" ;;
  }

  dimension: ram_overhead {
    type: number
    sql: ${TABLE}."Overhead" ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: num_zones {
    type: number
    sql: ${TABLE}."Prov" ;;
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
    sql: ${TABLE}."Sellable" ;;
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
    sql: ${TABLE}."Sold%" ;;
  }

  dimension: traits {
    type: string
    sql: ${TABLE}."traits" ;;
  }
  dimension: ssd_node {
    type: yesno
    sql: ${TABLE}.traits ->> 'ssd' is not null ;;

  }
  dimension: internal_node {
    type: yesno
    sql: ${TABLE}.traits ->> 'internal' is not null ;;

  }
  dimension: manta_node {
    type:  yesno
    sql:  ${TABLE}.traits ->> 'internal' is not null and ${TABLE}.traits ->> 'internal' = 'Manta Node' ;;
  }

  dimension: disk_unprovisioned {
    type: number
    sql: ${TABLE}."unprovisioned pool G" ;;
  }

  dimension: unprovisioned_ratio {
    type: number
    sql: ${TABLE}."unprovisioned ratio " ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}."uuid";;
  }
  dimension: pool {
    description: "All CNs except headnode and internal traited"
    type: yesno
    sql: ${cn_name} != 'headnode' and  ${TABLE}.traits ->> 'triton' is  null  and  ${TABLE}.traits ->> 'internal' is  null  ;;
  }
  dimension: general_pool {
    description: "All CNs for public use sans ssd"
    type: yesno
    sql: ${cn_name} != 'headnode' and  ${TABLE}.traits ->> 'internal' is  null and  ${TABLE}.traits ->> 'ssd' is  null and  ${TABLE}.traits ->> 'customer' is  null and  ${TABLE}.traits ->> 'storage' is  null and ${TABLE}.reserved != 'f'  ;;
  }
  dimension: general_ssd_pool {
    description: "All ssd CNs for public use"
    type: yesno
    sql:  ${TABLE}.traits ->> 'ssd' is  not null and  ${TABLE}.traits ->> 'customer' is  null and  ${TABLE}.traits ->> 'storage' is  null and ${TABLE}.reserved = 'f'  ;;
  }
  dimension: ssd_pool {
    description: "All ssd CNs"
    type: yesno
    sql:  ${TABLE}.traits ->> 'ssd' is  not null ;;
  }

  dimension: free_ram_tier {
    type: tier
    tiers: [16, 32,64,110, 220]
    sql:  ${ram_free}/1024 ;;
    style: integer
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
    sql:  ${ram_sellable}/1024.0/1024.0 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_free_total_t {
    type:  sum
    sql: ${ram_free}/1024.0/1024.0 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_total_g {
    type: sum
    sql:  ${ram_sellable}/1024.0 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_free_total_g {
    type:  sum
    sql: ${ram_free}/1024.0 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: disk_pool_total_t {
    type:  sum
    sql:  ${disk_pool}/1024.0/1024.0 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: disk_unprovisioned_total_t {
    type:  sum
    sql:  ${disk_unprovisioned}/1024.0/1024.0 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: ram_sold_total_t {
    type: sum
    sql: ${ram_sold}/1024.0/1024.0 ;;
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
  measure: avg_num_zones {
    type: average
    sql: ${num_zones} ;;
  }


}

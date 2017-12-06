# include: "values.view.lkml"

view: cnapi {
  sql_table_name: smartdc.cnapi ;;

  parameter: input_value {
    description: "I would create a table that has all the values you're okay with the user selecting. I created a derived
      table called 'values'
      Then, this filter field is going to provide a dropdown list of the options they could select from which is how
      you could control what they select/input. You could also just not put suggest_explore, or suggest_dimension and have
      it be a free form input of a-z or 0-9. Looker takes care of SQL injection."
    type: number
    suggest_explore: values
    suggest_dimension: ram_values.value
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
    sql: ${TABLE}."Cores" ;;
  }

  dimension: cpu_cores {
    type: number
    sql: ${TABLE}.cpu_cores ;;
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

  dimension: hwfamily {
    type: string
    sql: ${TABLE}.HWFamily ;;
  }

  dimension: hwversion {
    type: string
    sql: ${TABLE}.HWversion ;;
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
    sql:   ${cn_model} = 'Manta Shrimp' ;;
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

  dimension: unreserved_cpu {
    type: number
    sql: ${TABLE}.unreserved_cpu ;;
  }

  dimension: pool {
    description: "All unreserved CNs except internal or triton traited"
    type: yesno
    sql:   ${TABLE}.traits ->> 'internal' is  null and  ${TABLE}.traits ->> 'triton' is  null and ${TABLE}.traits ->> 'customers' is  null and NOT ${cn_reserved};;
  }
  dimension: isHeadnode {
    description: "Is this CN a headnode"
    type:  yesno
    sql:  ${cn_name} != 'headnode' and  ${TABLE}.traits ->> 'triton' != 'headnode' ;;
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
    tiers: [16, 32,64,110, 220]
    sql:  ${ram_free}/1024 ;;
    style: integer
  }

  dimension: unreserved_disk {
    type: number
    sql: ${TABLE}.unreserved_disk ;;
  }

  dimension: unreserved_ram {
    type: number
    sql: ${TABLE}.unreserved_ram ;;
  }

  dimension: live_pi_bucket{
    type:  tier
    tiers: [20140101, 20150101, 20160101, 20170101, 20180101]
    sql:  ${live_pi_number} ;;
    style: integer
 }
  dimension: num_ram_slots  {
    type: number
    description: "Variable ram slots"
    sql: floor( ${unreserved_ram} / (1024.0 * cast ({% parameter input_value %} as DOUBLE PRECISION)));;

  }
  dimension: ram_slots_available {
    type:  number
    sql: case when ${num_ram_slots} > 0 then ${num_ram_slots} else 0 END;;
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
    sql:  ${ram_sellable}/1024/1024 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_free_total_t {
    type:  sum
    sql: ${ram_free}/1024/1024 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_total_g {
    type: sum
    sql:  ${ram_sellable}/1024 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: ram_free_total_g {
    type:  sum
    sql: ${ram_free}/1024 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: disk_pool_total_t {
    type:  sum
    sql:  ${disk_pool}/1024/1024 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: disk_unprovisioned_total_t {
    type:  sum
    sql:  ${disk_unprovisioned}/1024/1024 ;;
    value_format_name: decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name,cn_model]
  }
  measure: ram_sold_total_t {
    type: sum
    sql: ${ram_sold}/1024/1024 ;;
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
    sql: ${unreserved_ram}/1024 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }

  measure: unreserved_disk_g {
    type:  sum
    sql: ${unreserved_disk}/1024 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
  measure: unreserved_ram_t {
    type:  sum
    sql: ${unreserved_ram}/1024/1024 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }

  measure: unreserved_disk_t {
    type:  sum
    sql: ${unreserved_disk}/1024/1024 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }

  measure: avg_num_zones {
    type: average
    sql: ${num_zones} ;;
  }
measure: sum_ram_slots_available {
  type:  sum
  sql:  ${ram_slots_available} ;;
}

}

view: cnapishort {
  sql_table_name: public.cnapishort ;;

  dimension: cores {
    type: number
    sql: ${TABLE}.Cores ;;
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
    sql: ${TABLE}."DCENTER";;
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

  dimension: num_kvm {
    type: number
    sql: ${TABLE}."kvm" ;;
  }
  dimension: joyent_percent {
    type: number
    sql: ${TABLE}."%joyent" ;;
  }
  dimension: num_lx {
    type: number
    sql: ${TABLE}."lx" ;;
  }
  dimension: kvm_percent {
    type: number
    sql: ${TABLE}."%kvm" ;;
  }
  dimension: cn_minimal {
    type: number
    sql: ${TABLE}."minimal" ;;
  }

  dimension: lx_percent {
    type: number
    sql: ${TABLE}."%lx" ;;
  }
  dimension: cn_model {
    type: string
    sql: ${TABLE}."Model" ;;
  }

  dimension: ram_overhead {
    type: number
    sql: ${TABLE}."Overhead" ;;
  }

  dimension: minimal_percent {
    type: number
    sql: ${TABLE}."%minimal" ;;
  }
  dimension: product_name{
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: num_zones {
    type: number
    sql: ${TABLE}."Prov" ;;
  }

  dimension: ram_sellable {
    type: number
    sql: ${TABLE}."Sellable" ;;
  }

  dimension: ram_sold {
    type: number
    sql: ${TABLE}."Sold" ;;
  }
  dimension: sold_percent {
    type: number
    sql: ${TABLE}."Sold%" ;;
  }
  dimension: disk_unprovisioned {
    type: number
    sql: ${TABLE}.|"unprovisioned pool G" ;;
  }

  dimension: unprovisioned_ratio {
    type: number
    sql: ${TABLE}."unprovisioned ratio " ;;
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
  measure: ram_sold_total_t {
    type: sum
    sql: ${ram_sold}/1024/1024 ;;
    value_format_name:  decimal_4
    drill_fields: [dc,cn_name,ram_sellable,product_name]
  }
}

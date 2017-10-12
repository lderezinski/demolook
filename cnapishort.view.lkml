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

  dimension: num_lx {
    type: number
    sql: ${TABLE}."lx" ;;
  }

  dimension: num_minimal {
    type: number
    sql: ${TABLE}."minimal" ;;
  }


  dimension: cn_model {
    type: string
    sql: ${TABLE}."Model" ;;
  }

  dimension: ram_overhead {
    type: number
    sql: ${TABLE}."Overhead" ;;
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
  measure: ram_total {
    type: sum
    sql:  ${ram_sellable} ;;
    value_format_name: decimal_4
  }
  measure: ram_free_total {
    type:  sum
    sql: ${ram_free} ;;
    value_format_name:  decimal_4
  }
}

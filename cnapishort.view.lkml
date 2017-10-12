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
    sql: ${TABLE}.DATE ;;
  }

  dimension: dcenter {
    type: string
    sql: ${TABLE}.DCENTER ;;
  }

  dimension: disk_pool_size_g {
    type: number
    sql: ${TABLE}."disk pool size G" ;;
  }

  dimension: ram_free {
    type: number
    sql: ${TABLE}.Free ;;
  }

  dimension: hostname {
    type: string
    sql: ${TABLE}.HOSTNAME ;;
  }

  dimension: joyent {
    type: number
    sql: ${TABLE}.joyent ;;
  }

  dimension: kvm {
    type: number
    sql: ${TABLE}.kvm ;;
  }

  dimension: lx {
    type: number
    sql: ${TABLE}.lx ;;
  }

  dimension: minimal {
    type: number
    sql: ${TABLE}.minimal ;;
  }


  dimension: model {
    type: string
    sql: ${TABLE}.Model ;;
  }

  dimension: ram_overhead {
    type: number
    sql: ${TABLE}.Overhead ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.Product ;;
  }

  dimension: prov {
    type: number
    sql: ${TABLE}.Prov ;;
  }

  dimension: ram_sellable {
    type: number
    sql: ${TABLE}.Sellable ;;
  }

  dimension: ram_sold {
    type: number
    sql: ${TABLE}.Sold ;;
  }

  dimension: disk_unprovisioned_pool_g {
    type: number
    sql: ${TABLE}."unprovisioned pool G" ;;
  }

  dimension: unprovisioned_ratio {
    type: number
    sql: ${TABLE}."unprovisioned ratio " ;;
  }

  measure: count {
    type: count
    drill_fields: [hostname]
  }
}

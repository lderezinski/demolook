view: spccnapishort {
  sql_table_name: public.spccnapishort ;;

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

  dimension: free {
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

  dimension: joyent-percent {
    type: number
    sql: ${TABLE}."%joyent" ;;
  }

  dimension: kvm {
    type: number
    sql: ${TABLE}.kvm ;;
  }

  dimension: kvm-percent {
    type: number
    sql: ${TABLE}."%kvm" ;;
  }

  dimension: lx {
    type: number
    sql: ${TABLE}.lx ;;
  }

  dimension: lx-percent {
    type: number
    sql: ${TABLE}."%lx" ;;
  }

  dimension: minimal {
    type: number
    sql: ${TABLE}.minimal ;;
  }

  dimension: minimal-percent {
    type: number
    sql: ${TABLE}."%minimal" ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.Model ;;
  }

  dimension: overhead {
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

  dimension: sellable {
    type: number
    sql: ${TABLE}.Sellable ;;
  }

  dimension: sold {
    type: number
    sql: ${TABLE}.Sold ;;
  }

  dimension: sold-percent {
    type: number
    sql: ${TABLE}."Sold%" ;;
  }

  dimension: unprovisioned_pool_g {
    type: number
    sql: ${TABLE}."unprovisioned pool G" ;;
  }

  dimension: unprovisioned_ratio_ {
    type: number
    sql: ${TABLE}."unprovisioned ratio " ;;
  }

  measure: count {
    type: count
    drill_fields: [hostname]
  }
}

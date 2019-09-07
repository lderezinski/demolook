view: bandwidth {
  sql_table_name: smartdc.bandwidth ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."datacenter"  || ${TABLE}."date" || ${TABLE}."owner_uuid";;
  }

  dimension: datacenter {
    type: string
    sql: ${TABLE}."datacenter" ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."date" ;;
  }

  dimension: in {
    type: number
    sql: ${TABLE}."in" ;;
  }

  dimension: out {
    type: number
    sql: ${TABLE}."out" ;;
  }

  dimension: owner_uuid {
    type: string
    sql: ${TABLE}."owner_uuid" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: in_k {
    type: sum_distinct
    sql:  ${in}/1000.0;;
  }
  measure: in_m {
    type: sum_distinct
    sql:  ${in}/1000.0/1000.0;;
  }
  measure: in_g {
    type: sum_distinct
    sql:  ${in}/1000.0/1000.0/1000.0;;
  }
  measure: in_t {
    type: sum_distinct
    sql:  ${in}/1000.0/1000.0/1000.0/1000.0;;
  }
  measure: in_p {
    type: sum_distinct
    sql:  ${in}/1000.0/1000.0/1000.0/1000.0/1000.0;;
  }
  measure: out_k {
    type: sum_distinct
    sql:  ${in}/1000.0;;
  }
  measure: out_m {
    type: sum_distinct
    sql:  ${out}/1000.0/1000.0;;
  }
  measure: out_g {
    type: sum_distinct
    sql:  ${out}/1000.0/1000.0/1000.0;;
  }
  measure: out_t {
    type: sum_distinct
    sql:  ${out}/1000.0/1000.0/1000.0/1000.0;;
  }
  measure: out_p {
    type: sum_distinct
    sql:  ${out}/1000.0/1000.0/1000.0/1000.0/1000.0;;
  }
}

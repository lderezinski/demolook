view: muskiedelete {
  sql_table_name: smartdc.muskiedelete ;;

  dimension: datacenter {
    type: string
    sql: ${TABLE}.datacenter ;;
  }

  dimension: deletedtb {
    type: number
    sql: ${TABLE}.deletedtb ;;
    value_format_name: decimal_4
  }

  dimension: normalized_deletedtb {
    type: number
    sql: ${deletedtb} / 2.0 ;;
    value_format_name: decimal_4
  }
  dimension: accelerated_gc {
    type: string
    sql: ${TABLE}.accelerated_gc ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: owner_uuid {
    type: string
    sql: ${TABLE}.owner_uuid ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.timestamp ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sumdelete_TB {
    type: sum
    sql: deletedtb ;;
    value_format_name: decimal_4
  }
  measure: sumdelete_PB {
    type: sum
    sql: deletedtb / 1024.0 ;;
    value_format_name: decimal_4
  }
  measure: normalized_sumdelete_TB {
    type: sum
    sql: normalized_deletedtb ;;
    value_format_name: decimal_4
  }

  measure: normalized_sumdelete_PB {
    type: sum
    sql: normalized_deletedtb / 1024.0 ;;
    value_format_name: decimal_4
  }
}

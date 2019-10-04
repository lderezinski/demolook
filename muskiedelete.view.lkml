view: muskiedelete {
  sql_table_name: smartdc.muskiedelete ;;


  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."timestamp"  || ${TABLE}."datacenter" || ${TABLE}."owner_uuid";;
  }

  dimension: datacenter {
    description: ""
    type: string
    sql: ${TABLE}.datacenter ;;
  }

  dimension: deletedtb {
    description: ""
    type: number
    sql: ${TABLE}.deletedtb ;;
    value_format_name: decimal_4
  }
# Per Elijah this is calculated from the web pov so it is already normalized
  dimension: normalized_deletedtb {
    description: ""
    type: number
    sql: ${deletedtb} ;;
    value_format_name: decimal_4
  }
  dimension: accelerated_gc {
    description: ""
    type: string
    sql: ${TABLE}.accelerated_gc ;;
  }
  dimension: region {
    description: ""
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: owner_uuid {
    description: ""
    type: string
    sql: ${TABLE}.owner_uuid ;;
  }

  dimension_group: timestamp {
    description: ""
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
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }

  measure: sumdelete_TiB {
    description: ""
    type: sum
    sql: ${deletedtb} ;;
    value_format_name: decimal_4
  }
  measure: sumdelete_PiB {
    description: ""
    type: sum
    sql: ${deletedtb} / 1024.0 ;;
    value_format_name: decimal_4
  }
  # Per Elijah this is calculated from the web pov so it is already normalized
  measure: normalized_sumdelete_TiB {
    description: ""
    type: sum
    sql: ${deletedtb} ;;
    value_format_name: decimal_4
  }
# Per Elijah this is calculated from the web pov so it is already normalized
  measure: normalized_sumdelete_PiB {
    description: ""
    type: sum
    sql: ${deletedtb} / 1024.0 ;;
    value_format_name: decimal_4
  }
}

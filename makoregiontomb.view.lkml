view: makoregiontomb {
  sql_table_name: smartdc.makoregiontomb ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.storage_id || ${TABLE}.date  ;;
  }
  dimension: cloud {
    description: "JPC or SPC"
    type: string
    sql: ${TABLE}.cloud ;;
  }
  dimension: datacenter {
    description: "Name of the datacenter"
    type: string
    sql: ${TABLE}.datacenter ;;
  }
  dimension_group: modify_date {
    description: "timestamp of the last time data was updated"
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
    sql: ${TABLE}.modify_date ;;
  }
  dimension_group: date {
    description: "date of the data collection"
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
    sql: ${TABLE}.date ;;
  }

  dimension: kilobytes {
    type: number
    sql: ${TABLE}.kiliobytes ;;
  }

  dimension: objects {
    type: number
    sql: ${TABLE}.objects ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: storage_id {
    type: string
    sql: ${TABLE}.storage_id ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: sum_p {
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_t {
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_g {
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: total_objects {
    type:  sum
    sql: ${objects} ;;
  }
}

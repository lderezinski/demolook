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
    description: "mako reported size of tomestone in KiB"
    type: number
    sql: ${TABLE}.kiliobytes ;;
  }

  dimension: objects {
    description: "mako reported number of objects in the tomestone"
    type: number
    sql: ${TABLE}.objects ;;
  }

  dimension: region {
    description: "mako region"
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: storage_id {
    description: "mako storage id"
    type: string
    sql: ${TABLE}.storage_id ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: sum_p {
    description: "mako size of tomestone in PiB"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_t {
    description: "mako size of tomestone in TiB"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: sum_g {
    description: "mako size of tomestone in GiB"
    type:  sum
    sql: ${kilobytes}/1024.0/1024.0 ;;
    value_format_name: decimal_3
  }
  measure: total_objects {
    description: "mako total number of objects in the tomestone"
    type:  sum
    sql: ${objects} ;;
  }
}

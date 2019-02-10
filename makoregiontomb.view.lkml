view: makoregiontomb {
  sql_table_name: smartdc.makoregiontomb ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.storage_id || ${TABLE}.date  ;;
  }
  dimension: cloud {
    type: string
    sql: when case region = 'us-east-1' then 'JPC'
              case region = 'us-east-2' then 'JPC'
              case region = 'us-east-3' then 'JPC'
              else 'SPC'
        end ;;
  }
  dimension: datacenter {
    type: string
    sql: ${TABLE}.datacenter ;;
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

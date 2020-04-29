view: jccontracts {
  sql_table_name: smartdc.jccontracts ;;
  dimension: compound_primary_key {
    description: "primary key contractEnd and uuid"
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.contractEnd || ${TABLE}.uuid;;
  }
  dimension_group: contract_end {
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
    sql: ${TABLE}.contractEnd ;;
  }

  dimension_group: contract_start {
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
    sql: ${TABLE}.contractStart ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.Customer ;;
  }

  dimension: out_tib_limit {
    type: number
    sql: ${TABLE}.outTiBLimit ;;
  }

  dimension: report_name {
    type: string
    sql: ${TABLE}.ReportName ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  measure: count {
    type: count
    drill_fields: [report_name]
  }
}

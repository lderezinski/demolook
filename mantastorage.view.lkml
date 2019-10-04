view: mantastorage {
  sql_table_name: smartdc.mantastorage ;;


  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."date"  || ${TABLE}."owner" || ${TABLE}."type";;
  }


  dimension: bytes {
    description: ""
    type: number
    sql: ${TABLE}.bytes ;;
    value_format_name: decimal_0
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: directories {
    description: ""
    type: number
    sql: ${TABLE}.directories ;;
  }

  dimension: keys {
    description: ""
    type: number
    sql: ${TABLE}.keys ;;
  }

  dimension: objects {
    description: ""
    type: number
    sql: ${TABLE}.objects ;;
  }

  dimension: owner {
    description: ""
    type: string
    sql: ${TABLE}.owner ;;
  }

  dimension: type {
    description: ""
    type: string
    sql: ${TABLE}.type ;;
  }
  dimension: bytes_g {
    description: ""
    type: number
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  dimension: bytes_t {
    description: ""
    type: number
    sql: ${bytes}/1024.0/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  dimension: bytes_p {
    description: ""
    type: number
    sql: ${bytes}/1024.0/1024.0/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: sumbytes {
    description: ""
    type: sum_distinct
    sql: ${bytes} ;;
    value_format_name: decimal_0
  }
  measure: sumbytes_g {
    description: ""
    type: sum_distinct
    sql: ${bytes_g} ;;
    value_format_name: decimal_4
  }
  measure: sumbytes_t {
    description: ""
    type: sum_distinct
    sql: ${bytes_t} ;;
    value_format_name: decimal_4
  }
  measure: sumbytes_p {
    description: ""
    type: sum_distinct
    sql: ${bytes_p} ;;
    value_format_name: decimal_4
  }
  measure: sumdirs {
    description: ""
    type: sum_distinct
    sql: ${directories} ;;
    value_format_name: decimal_0
  }
  measure: sumobjs {
    description: ""
    type: sum_distinct
    sql: ${objects} ;;
    value_format_name: decimal_0
  }
  measure: public_stor_g {
    description: ""
    type: sum
    filters: {
      field: type
      value: "public, stor"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: reports_jobs_g {
    description: ""
    type: sum
    filters: {
      field: type
      value: "reports, jobs"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: reports_g {
    description: ""
    type: sum
    filters: {
      field: type
      value: "reports"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: jobs_g {
    description: ""
    type: sum
    filters: {
      field: type
      value: "jobs"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: stor_g {
    description: ""
    type: sum
    filters: {
      field: type
      value: "stor"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: public_g {
    description: ""
    type: sum
    filters: {
      field: type
      value: "public"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
}

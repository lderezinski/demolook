view: mantastorage {
  sql_table_name: smartdc.mantastorage ;;


  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date  || ${TABLE}.owner || ${TABLE}."TYPE";;
  }


  dimension: bytes {
    description: "Amount of storage consumed in bytes"
    type: number
    sql: ${TABLE}.bytes ;;
    value_format_name: decimal_0
  }

  dimension_group: date {
    description: "Timestamp of data collection"
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
    description: "Number of directories"
    type: number
    sql: ${TABLE}.directories ;;
  }

  dimension: keys {
    description: "The Number of keys"
    type: number
    sql: ${TABLE}.keys ;;
  }

  dimension: objects {
    description: "The Number of objects"
    type: number
    sql: ${TABLE}.objects ;;
  }

  dimension: owner {
    description: "The UFDS UUID of the account"
    type: string
    sql: ${TABLE}.owner ;;
  }

  dimension: type {
    description: "One of: stor,pubilc,reports,jobs"
    type: string
    sql: ${TABLE}.type ;;
  }
  dimension: bytes_g {
    description: "Consumed storage in GiB"
    type: number
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  dimension: bytes_t {
    description: "Consumed storage in TiB"
    type: number
    sql: ${bytes}/1024.0/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  dimension: bytes_p {
    description: "Consumed storage in PiB"
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
    description: "Sum Consumed storage in bytes"
    type: sum_distinct
    sql: ${bytes} ;;
    value_format_name: decimal_0
  }
  measure: sumbytes_g {
    description: "Sum Consumed storage in GiB"
    type: sum_distinct
    sql: ${bytes_g} ;;
    value_format_name: decimal_4
  }
  measure: sumbytes_t {
    description: "Sum Consumed storage in TiB"
    type: sum_distinct
    sql: ${bytes_t} ;;
    value_format_name: decimal_4
  }
  measure: sumbytes_p {
    description: "Sum Consumed storage in PiB"
    type: sum_distinct
    sql: ${bytes_p} ;;
    value_format_name: decimal_4
  }
  measure: sumdirs {
    description: "Sum Consumed storage in bytes"
    type: sum_distinct
    sql: ${directories} ;;
    value_format_name: decimal_0
  }
  measure: sumobjs {
    description: "Sum number of objects in storage"
    type: sum_distinct
    sql: ${objects} ;;
    value_format_name: decimal_0
  }
  measure: public_stor_g {
    description: "Sum Consumed storage in GiB in Public and stor"
    type: sum
    filters: {
      field: type
      value: "public, stor"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: reports_jobs_g {
    description: "Sum consumed storage in GiB for reports and jobs"
    type: sum
    filters: {
      field: type
      value: "reports, jobs"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: reports_g {
    description: "Sum of consumed storage in reports GiB"
    type: sum
    filters: {
      field: type
      value: "reports"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: jobs_g {
    description: "Sum of consumed storage in jobs GiB"
    type: sum
    filters: {
      field: type
      value: "jobs"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: stor_g {
    description: "Sum of consumed storage in stor GiB"
    type: sum
    filters: {
      field: type
      value: "stor"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
  measure: public_g {
    description: "Sum of consumed storage in public GiB"
    type: sum
    filters: {
      field: type
      value: "public"
    }
    sql: ${bytes}/1024.0/1024.0/1024.0 ;;
    value_format_name: decimal_4
  }
}

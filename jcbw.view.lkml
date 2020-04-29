view: jcbw {
  sql_table_name: smartdc.jcbw ;;
  dimension: compound_primary_key {
    description: "primary key date and uuid"
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date || ${TABLE}.reportname;;
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

  dimension: in_gib {
    type: number
    sql: ${TABLE}.inGiB ;;
  }

  dimension: inavgbps {
    type: number
    sql: ${TABLE}.inavgbps ;;
  }

  dimension: out_gib {
    type: number
    sql: ${TABLE}.outGiB ;;
  }

  dimension: outavgbps {
    type: number
    sql: ${TABLE}.outavgbps ;;
  }

  dimension: report_name {
    type: string
    sql: ${TABLE}.reportname ;;
  }

  dimension: seconds {
    type: number
    sql: ${TABLE}.seconds ;;
  }

  measure: count {
    type: count
    drill_fields: [report_name]
  }
  measure:  averagein_gib{
    type: average
    sql:  ${in_gib};;
  }

  measure:  averageout_gib{
    type: average
    sql:  ${out_gib};;
  }

  measure:  sumin_gib{
    type: sum
    sql:  ${in_gib};;
  }

  measure:  sumout_gib{
    type: sum
    sql:  ${out_gib};;
  }
}

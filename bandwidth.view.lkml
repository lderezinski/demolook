view: bandwidth {
  sql_table_name: smartdc.bandwidth ;;

  dimension: compound_primary_key {
    description: "primary key datacenter, date and owner uuid"
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.datacenter || ${TABLE}.date || ${TABLE}.owner_uuid;;
  }

  dimension: datacenter {
    type: string
    description: "datacenter from instances.json"
    sql: ${TABLE}.datacenter ;;
  }

  dimension_group: date {
    type: time
    description: "YYYY-MM-DD, data collected on a daily cadence at the end of the day "
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

  dimension: in {
    description: "total number of bytes in on public interface "
    type: number
    sql: ${TABLE}.bw_in ;;
  }

  dimension: out {
    description: "total number of bytes out on public interface"
    type: number
    sql: ${TABLE}.bw_out ;;
  }

  dimension: owner_uuid {
    description: "ufds uuid for customer"
    type: string
    sql: ${TABLE}.owner_uuid ;;
  }

  measure: count {
    description: "count of bw records"
    type: count
    drill_fields: []
  }
  measure: in_k {
    description: "total number of kilobytes in on public interface "
    type: sum_distinct
    sql:  ${in}/1000.0;;
  }
  measure: in_m {
    description: "total number of megabytes in on public interface "
    type: sum_distinct
    sql:  ${in}/1000.0/1000.0;;
  }
  measure: in_g {
    description: "total number of gigabytes in on public interface "
    type: sum_distinct
    sql:  ${in}/1000.0/1000.0/1000.0;;
  }
  measure: in_t {
    description: "total number of terabytes in on public interface "
    type: sum_distinct
    sql:  ${in}/1000.0/1000.0/1000.0/1000.0;;
  }
  measure: in_p {
    description: "total number of petabytes in on public interface "
    type: sum_distinct
    sql:  ${in}/1000.0/1000.0/1000.0/1000.0/1000.0;;
  }
  measure: out_k {
    description: "total number of kilobytes out on public interface"
    type: sum_distinct
    sql:  ${in}/1000.0;;
  }
  measure: out_m {
    description: "total number of megabytes out on public interface"
    type: sum_distinct
    sql:  ${out}/1000.0/1000.0;;
  }
  measure: out_g {
    description: "total number of gigabytes out on public interface"
    type: sum_distinct
    sql:  ${out}/1000.0/1000.0/1000.0;;
  }
  measure: out_t {
    description: "total number of terabytes out on public interface"
    type: sum_distinct
    sql:  ${out}/1000.0/1000.0/1000.0/1000.0;;
  }
  measure: out_p {
    type: sum_distinct
    description: "total number of petabytes out on public interface"
    sql:  ${out}/1000.0/1000.0/1000.0/1000.0/1000.0;;
  }
}

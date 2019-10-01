view: storagebuild {
  sql_table_name: capacity.storagebuild ;;

  dimension_group: deliver {
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
    sql: ${TABLE}."DeliverDate" ;;
  }

  measure: delivery_month_list {
    type: string
    sql: string_agg(${deliver_month},', ') ;;
  }

  dimension: fcst {
    type: string
    sql: ${TABLE}."FCST" ;;
  }

  dimension: group {
    type: string
    sql: ${TABLE}."group" ;;
  }

  dimension: manta_capacity_pib {
    type: number
    sql: ${TABLE}."Manta_capacity_PiB" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."Region" ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}."StartDate" ;;
  }
  dimension: status_leg {
    type: number
    sql: case when ${status} = 'Delivered' then 4
              when ${status} = 'pre-pumi' then 1
              when ${status} = 'ordering' then 2
              when ${status} = 'Building' then 3
              else null
          end;;
   html: {{status._value}} | {{sum_manta_cap_pib._value}} ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}."Status" ;;
  }
  dimension: status_label {
    type: number
    sql: case when ${status} = 'Delivered' then 'Delivered'
              when ${status} = 'pre-pumi'  then 'Pre-Pumi'
              when ${status} = 'ordering'  then 'In progress'
              when ${status} = 'Building'  then 'In progress'
              else null
          end;;
  }
  dimension: sold_out_date {
    type: date
    sql:  DATE ${deliver_raw} + INTERVAL ' 46 days' ;;

  }
  dimension: region_status {
    type: string
    sql:  ${region}|| '-'||${fcst} || '-'|| ${status_label} ;;
  }
  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }

  measure: sum_manta_cap_pib {
    type: sum
    sql: ${manta_capacity_pib} ;;
    value_format_name: decimal_2

  }
  measure: burn_rate_days {
    type: string
    sql: ${sum_manta_cap_pib} / 0.9 ;;
  }

}

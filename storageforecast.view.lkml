view: storageforecast {
  sql_table_name: capacity.storageforecast ;;

  dimension: cumulative_data_pib {
    type: number
    sql: ${TABLE}."cumulative_data_PiB" ;;
  }

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${region}, ${date_raw},${fcst}) ;;
  }
  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      month_num,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."Date" ;;
  }

  dimension: half_year {
    type: string
    sql: case when ${date_month_num} < 7 then concat(${date_year},'-06')
              when  ${date_month_num} >= 7 then concat(${date_year},'-12')
              else null end
        ;;
  }

  dimension: is_halfyear{
    type:  yesno
    sql:  ${date_month_num} = 12 or ${date_month_num} = 6 ;;
  }
  measure: halfyear_target {
    type: sum
    sql:  ${manta_capacity_pib};;
    filters: {
      field: is_halfyear
      value: "Yes"
      }

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

  measure: count {
    type: count
    drill_fields: []
  }
  measure: sum_manta_cap_pib {
    type: sum
    sql: ${manta_capacity_pib} ;;
  }
  measure: sum_cum_data_pib {
    type: sum
    sql: ${cumulative_data_pib} ;;
  }
}

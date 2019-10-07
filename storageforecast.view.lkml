view: storageforecast {
  sql_table_name: capacity.storageforecast ;;

  dimension: cumulative_data_pib {
    description: "After build is complete, total PiB will be"
    type: number
    sql: ${TABLE}."cumulative_data_PiB" ;;
  }

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${region}, ${delivery_raw},${fcst}) ;;
  }
  dimension_group: delivery {
    description: "Date of expected delivery"
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
    description: "return YYYY-06 or YYYY-12 which part of the year that this deivery occurs"
    type: string
    sql: case when ${delivery_month_num} < 7 then concat(${delivery_year},'-06')
              when  ${delivery_month_num} >= 7 then concat(${delivery_year},'-12')
              else null end;;
  }

  dimension: is_halfyear{
    description: "Boolean if the delivery month is 6 or 12"
    type:  yesno
    sql:  ${delivery_month_num} = 12 or ${delivery_month_num} = 6 ;;
  }
  measure: halfyear_target {
    description: "number of builds which are halfyear_targets"
    type: sum
    sql:  ${manta_capacity_pib};;
    filters: {
      field: is_halfyear
      value: "Yes"
    }

  }
  dimension: fcst {
    description: "The forcast version this storage build is in"
    type: string
    sql: ${TABLE}."FCST" ;;
  }

  dimension: group {
    description: "Is this a JPC or SPC build"
    type: string
    sql: ${TABLE}."group" ;;
  }

  dimension: manta_capacity_pib {
    description: "The manta capacity for this build in PiB"
    type: number
    sql: ${TABLE}."Manta_capacity_PiB" ;;
  }

  dimension: region {
    description: "The region of this build "
    type: string
    sql: ${TABLE}."Region" ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: sum_manta_cap_pib {
    description: "The sum of the manta capacity in PiB"
    type: sum
    sql: ${manta_capacity_pib} ;;
  }
  measure: sum_cum_data_pib {
    description: "The sum of the cumulative mata capacity in PiB"
    type: sum
    sql: ${cumulative_data_pib} ;;
  }
}

view: storagebuild {
  sql_table_name: capacity.storagebuild ;;

  dimension_group: deliver {
    description: "The timestamp of the storage being delivered"
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
    sql: ${TABLE}.deliverdate ;;
  }

  measure: delivery_month_list {
    description: "The list of the delievery months"
    type: string
    sql: listagg(${deliver_month}, ', ') ;;
  }

  dimension: fcst {
    description: "Which forcast verion is this build based"
    type: string
    sql: ${TABLE}.FCST ;;
  }

  dimension: group {
    description: "Is this JPC or SPC"
    type: string
    sql: ${TABLE}."group" ;;
  }

  dimension: manta_capacity_pib {
    description: "Total PiB being added in this build"
    type: number
    sql: ${TABLE}.Manta_capacity_PiB ;;
  }

  dimension: region {
    description: "Region which PiB is being added to the build"
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension_group: start {
    description: "Start date of the build"
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
    sql: ${TABLE}.StartDate ;;
  }
  dimension: status_leg {
    description: "The status of this current build: 1-pre-pumi,2-ordering,3-Building,4-Delivered"
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
    description: "The status of this current build: pre-pumi,ordering,Building,Delivered"
    type: string
    sql: ${TABLE}.Status ;;
  }
  dimension: status_label {
    description: "The build status normalized to Pre-Pumi, In Progress or Delivered"
    type: number
    sql: case when ${status} = 'Delivered' then 'Delivered'
              when ${status} = 'pre-pumi'  then 'Pre-Pumi'
              when ${status} = 'ordering'  then 'In progress'
              when ${status} = 'Building'  then 'In progress'
              else null
          end;;
  }
  dimension: sold_out_date {
    description: "expected full date based on current burn rate"
    type: date
    sql:  DATEADD('days', 46,  ${deliver_raw} ) ;;

  }
  dimension: region_status {
    description: "returns the region-forcast-status_label"
    type: string
    sql:  ${region}|| '-'||${fcst} || '-'|| ${status_label} ;;
  }
  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }

  measure: sum_manta_cap_pib {
    description: "Sum of the manta capacity in PiB"
    type: sum
    sql: ${manta_capacity_pib} ;;
    value_format_name: decimal_2

  }
  measure: burn_rate_days {
    description: "Number of days until full"
    type: string
    sql: ${sum_manta_cap_pib} / 0.9 ;;
  }

}

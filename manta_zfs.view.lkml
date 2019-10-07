view: manta_zfs {
  sql_table_name: capacity.manta_zfs ;;


  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}."date"  || ${TABLE}."region" ;;
  }

  dimension_group: date {
    description: "Timestamp of data collected"
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

  dimension: region {
    description: "Region where data collected"
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: zfs_available_bytes {
    description: "zfs bytes available Normalized to 2 copies and 96% zfs reserve"
    type: number
    # sql:GREATEST(${TABLE}.zfs_available/2 - 0.05 *(${TABLE}.zfs_available/2 +${zfs_used_bytes}),0);;
    sql:GREATEST(${TABLE}.zfs_available/2 - 0.04 *(${TABLE}.zfs_available/2 +${zfs_used_bytes}),0);;
    value_format_name: decimal_2
  }

  dimension: zfs_used_bytes {
    description: "zfs bytes used normalized to 2 copies"
    type: number
    sql: ${TABLE}.zfs_used/2 ;;
    value_format_name: decimal_2
  }
  dimension: zfs_available_pib {
    description: "zfs PiB available normalized to 2 copies and 96% reserve"
    type: number
    sql: ${zfs_available_bytes}/1125899906842624.0 ;;
    value_format_name: decimal_2
  }

  dimension: zfs_used_pib {
    description: "zfs PiB used normalized to 2 copies"
    type: number
    sql: ${zfs_used_bytes}/1125899906842624.0 ;;
    value_format_name: decimal_2
  }
  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: total_pib {
    description: "zfs PiB available normalized to 2 copies and 96% reserve + zfs bytes available Normalized to 2 copies and 96% zfs reserve"
    type:  sum
    sql: ${zfs_used_pib} + ${zfs_available_pib}  ;;
    drill_fields: [date_date,region,zfs_used_pib,zfs_available_pib]
    value_format_name: decimal_2
  }
  measure: total_used_pib {
    description: "zfs PiB available normalized to 2 copies and 96% reserve + zfs bytes available Normalized to 2 copies and 96% zfs reserve"
    type:  sum
    sql: ${zfs_used_pib} ;;
    drill_fields: [date_date,region,zfs_used_pib,zfs_available_pib]
    value_format_name: decimal_2
  }
  measure: total_available_pib {
    description: "zfs PiB available normalized to 2 copies and 96% reserve"
    type:  sum
    sql: ${zfs_available_pib} ;;
    drill_fields: [date_date,region,zfs_used_pib,zfs_available_pib]
    value_format_name: decimal_2
  }
  measure: used_or_null_pib {
    description: "Return NULL or zfs PiB used normalized to 2 copies"
    type:  number
    sql:
    CASE
      WHEN ${zfs_used_pib} = 0 THEN NULL
      ELSE ${zfs_used_pib}
    END;;

    drill_fields: [date_date,region,zfs_used_pib,zfs_available_pib]
    value_format_name: decimal_2
  }

  dimension: goal640 {
    description: "The PiB values by region which total 640 PiB"
    type: number
    sql: CASE when ${region} = 'us-east' THEN 195
              when ${region} = 'eu-central' THEN 227
             when ${region} = 'ap-northeast' THEN 115
             when ${region} = 'ap-southeast' THEN 103
            END
    ;;
  }
}

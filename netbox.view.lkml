view: netbox {
  sql_table_name: capacity.netbox ;;
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.name || ${TABLE}.site ||  ${TABLE}.date.date;;
  }
  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: rack {
    type: string
    sql: ${TABLE}.rack ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: serial {
    type: string
    sql: ${TABLE}.serial ;;
  }

  dimension: site {
    type: string
    sql: ${TABLE}.site ;;
  }
  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }
  dimension: region{
    type: string
    sql: CASE
            WHEN ${site} = 'us-east-1a' THEN 'us-east-1'
            WHEN ${site} = 'us-east-1b' THEN 'us-east-1'
            WHEN ${site} = 'us-east-1c' THEN 'us-east-1'
            WHEN ${site} = 'eu-central-1a' THEN 'eu-central-1'
            WHEN ${site} = 'eu-central-1b' THEN 'eu-central-1'
            WHEN ${site} = 'eu-central-1c' THEN 'eu-central-1'
            WHEN ${site} = 'ap-northeast-1a' THEN 'ap-northeast-1'
            WHEN ${site} = 'ap-northeast-1b' THEN 'ap-northeast-1'
            WHEN ${site} = 'ap-northeast-1c' THEN 'ap-northeast-1'
            WHEN ${site} = 'ap-southeast-1a' THEN 'ap-southeast-1'
            WHEN ${site} = 'ap-southeast-1b' THEN 'ap-southeast-1'
            WHEN ${site} = 'ap-southeast-1c' THEN 'ap-southeast-1'
            ELSE ${site}
            END;;
  }
  dimension: tags {
    type: string
    sql: ${TABLE}.tags::TEXT ;;
  }

  dimension: tenant {
    type: string
    sql: ${TABLE}.tenant ;;
  }
  dimension: manufacture {
    type: string
    sql: CASE
           WHEN length(${serial}) = 7 THEN 'DELL'
           WHEN length(${serial}) = 15 THEN 'SMCI'
           WHEN ${device_type}  = 'Super Server-19' THEN 'SMCI'
           ELSE 'Unknown'
          END;;
  }
  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [name, region, rack, role, device_type, serial]
  }
}

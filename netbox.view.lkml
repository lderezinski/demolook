view: netbox {
  sql_table_name: capacity.netbox ;;

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
    sql: ${TABLE}.tags ;;
  }

  dimension: tenant {
    type: string
    sql: ${TABLE}.tenant ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}

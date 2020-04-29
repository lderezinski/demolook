view: netbox {
  sql_table_name: capacity.netbox ;;
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.name || ${TABLE}.site ||  ${TABLE}.date.date;;
  }
  dimension: device_type {
    description: "netbox.device_type.model"
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: name {
    description: "netbox.comments parsed out value for site.name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: platform {
    description: "netbox.comments parsed out value for platform"
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: rack {
    description: "netbox.rack.display_name"
    type: string
    sql: ${TABLE}.rack ;;
  }

  dimension: role {
    description: "netbox.device_role.name"
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: serial {
    description: "netbox.display_name"
    type: string
    sql: ${TABLE}.serial ;;
  }

  dimension: site {
    description: "the name of the AZ"
    type: string
    sql: ${TABLE}.site ;;
  }
  dimension_group: date {
    description: "timestamp of the data collection"
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
    description: "The region name derivied from site, removing the 1a,1b,1c from the site"
    type: string
    sql: CASE WHEN  right(${site}, 2) = '1a' THEN left(${site}, (length(${site})::integer - 1))
              WHEN  right(${site}, 2) = '1b' THEN left(${site}, (length(${site})::integer - 1))
              WHEN  right(${site}, 2) = '1c' THEN left(${site}, (length(${site})::integer - 1))
              ELSE ${site}
        END;;
  }
  dimension: tags {
    description: "JSON to Text netbox.tags"
    type: string
    sql: ${TABLE}.tags::TEXT ;;
  }

  dimension: tenant {
    description: "netbox.tenant.name"
    type: string
    sql: ${TABLE}.tenant ;;
  }
  dimension: manufacture {
    description: "Parsing of the serial number to determine the manufacture DELL or SMCI"
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

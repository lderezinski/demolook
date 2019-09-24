view: datacenters {
  sql_table_name: smartdc.datacenters ;;

  dimension: group {
    description: "One of JPC, SPC, etc"
    type: string
    sql: ${TABLE}."group" ;;
  }
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.group, '  ', ${TABLE}.name) ;;
  }
  dimension: name {
    description: "The proper name XX-XXXXXXX-#x"
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: region {
    description: "The full region name us-east-1 vs us-east-1a"
    type: string
    sql:  CASE
      WHEN ${group} = 'SPC' THEN left(${name}, length(${name}) - 1)
      else ${name}
      END;;
  }

  measure: count {
    description: "The number items"
    type: count
    drill_fields: [name]
  }
}

view: datacenters {
  sql_table_name: smartdc.datacenters ;;

  dimension: group {
    type: string
    sql: ${TABLE}."group" ;;
  }
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.group, '  ', ${TABLE}.name) ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: region {
    type: string
    sql:  CASE
      WHEN ${group} = 'SPC' THEN left(${name}, length(${name}) - 1)
      else ${name}
      END;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}

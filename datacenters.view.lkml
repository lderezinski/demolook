view: datacenters {
  sql_table_name: smartdc.datacenters ;;

  dimension: group {
    type: string
    sql: ${TABLE}."group" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}

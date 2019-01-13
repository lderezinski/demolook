view: ufdsgroupname {
  sql_table_name: smartdc.ufdsgroupname ;;

  dimension: groupname {
    type: string
    sql: ${TABLE}.groupname ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  measure: count {
    type: count
    drill_fields: [groupname]
  }
}

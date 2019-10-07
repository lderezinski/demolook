view: ufdsgroupname {
  sql_table_name: smartdc.ufdsgroupname ;;

  dimension: groupname {
    description: "Groupname for the account"
    type: string
    sql: ${TABLE}.groupname ;;
  }

  dimension: uuid {
    description: "UFDS.uuid"
    type: string
    primary_key: yes
    sql: ${TABLE}.uuid ;;
  }

  dimension: paidorfree {
    description: "Returns either Customer or Internal or Free - 3rd party/test/Fraud"
    type:  string
    sql:  CASE WHEN ${groupname} = 'Invoice' THEN 'Customer'
               WHEN ${groupname} = 'Credit Card' THEN 'Customer'
               WHEN ${groupname} = 'Internal - Department' THEN 'Internal'
               WHEN ${groupname} = 'Internal - Employee' THEN 'Internal'
               WHEN ${groupname} = 'Employee Personal Use' THEN 'Customer'
               ELSE 'Free - 3rd party/test/Fraud'
          END;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [groupname]
  }
}

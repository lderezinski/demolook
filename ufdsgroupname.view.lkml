view: ufdsgroupname {
  sql_table_name: smartdc.ufdsgroupname ;;
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.uuid  ;;
  }
  dimension: groupname {
    type: string
    sql: ${TABLE}.groupname ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: paidorfree {
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
    type: count
    drill_fields: [groupname]
  }
}

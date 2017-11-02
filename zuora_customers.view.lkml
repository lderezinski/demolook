view: zuora_customers {
  sql_table_name: smartdc.zuora_customers ;;

  dimension: accountnumber {
    type: string
    primary_key: yes
    sql: ${TABLE}.accountnumber ;;
  }

  dimension: batch {
    type: string
    sql: ${TABLE}.batch ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
  }

  dimension_group: createddate {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createddate ;;
  }

  dimension: crmid {
    type: string
    sql: ${TABLE}.crmid ;;
  }

  dimension: fname {
    type: string
    sql: ${TABLE}.fname ;;
  }

  dimension: lname {
    type: string
    sql: ${TABLE}.lname ;;
  }

  dimension: zuoraid {
    type: string
    sql: ${TABLE}.zuoraid ;;
  }

  measure: count {
    type: count
    drill_fields: [fname, lname]
  }
}

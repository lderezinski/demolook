view: zuora_customers {
  sql_table_name: smartdc.zuora_customers ;;

  dimension: accountnumber {
    description: "The UFDS.uuid for this account"
    type: string
    primary_key: yes
    sql: ${TABLE}.accountnumber ;;
  }

  dimension: batch {
    description: "the zuora batch number the account is in"
    type: string
    sql: ${TABLE}.batch ;;
  }

  dimension: category {
    description: "the customer category for this account"
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: company {
    description: "The name of the company in zuora"
    type: string
    sql: ${TABLE}.company ;;
    link: {
      label: "{{ value }} - Lookup Account"
      url: "/dashboards/17?Account%20Number={{ accountnumber._value }}"
    }
  }

  dimension_group: createddate {
    description: "The created date into zuora Accounts"
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
    datatype: date
  }

  dimension: crmid {
    description: "The Salesforce crmid"
    type: string
    sql: ${TABLE}.crmid ;;
  }

  dimension: fname {
    description: "Zuora Billing contact first name"
    type: string
    sql: ${TABLE}.fname ;;
  }

  dimension: lname {
    description: "Zuora Billing contact last name"
    type: string
    sql: ${TABLE}.lname ;;
  }

  dimension: zuoraid {
    description: "Zuora account id"
    type: string
    sql: ${TABLE}.zuoraid ;;
  }

  dimension: isFree {
    description: "The customer is not in a paying batch"
    type: yesno
    sql: ${category} != 'Invoice' AND ${category} != 'Employee Personal Use' AND ${category} != 'Credit Card' ;;
  }


  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [fname, lname]
  }
}

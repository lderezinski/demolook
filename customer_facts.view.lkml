# explore: customer_facts {}
view: customer_facts {
  derived_table: {
    sql_trigger_value: select DATE_TRUNC('month',current_date);;
    sql: SELECT *
        , lead(total_amount) over(PARTITION BY  table_a.email ORDER by email, table_a.charge_month DESC) as previous_amount
        , row_number() over() as id
      FROM (

      SELECT
        ufds.email  AS "email",
        TO_CHAR(DATE_TRUNC('month', zinvoiceitems."ChargeDate" ), 'YYYY-MM') AS "charge_month",
        COALESCE(SUM(("ChargeAmount") ), 0) AS "total_amount"
      FROM smartdc.zinvoiceitems  AS zinvoiceitems
      LEFT JOIN smartdc.ufds  AS ufds ON ("AccountNumber") = ufds.uuid
      LEFT JOIN smartdc.zuora_customers  AS zuora_customers ON zuora_customers.accountnumber = ("AccountNumber")

      GROUP BY 1,DATE_TRUNC('month', zinvoiceitems."ChargeDate" )
      ) as table_a
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    primary_key: yes
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: charge_month {
    type: string
    sql: ${TABLE}.charge_month ;;
  }

  dimension: total_amount {
    type: string
    sql: ${TABLE}.total_amount ;;
  }

  dimension: previous_amount {
    type: string
    sql: ${TABLE}.previous_amount ;;
  }

  set: detail {
    fields: [email, charge_month, total_amount, previous_amount]
  }
}

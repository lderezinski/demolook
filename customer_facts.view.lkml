view: customer_facts {
  derived_table: {
    sql_trigger_value: select DATE_TRUNC('month',current_date);;
    indexes: ["email"]
    sql: SELECT *
        , lead(total_amount) over(PARTITION BY  table_a.email ORDER by email, table_a.charge_month DESC) as previous_amount
        , row_number() over() as id
      FROM (

      SELECT
        ufds.email  AS "email",
        DATE_TRUNC('month', zinvoiceitems."ChargeDate" ) AS "charge_month",
        COALESCE(SUM(("ChargeAmount") ), 0) AS "total_amount"
      FROM smartdc.zinvoiceitems  AS zinvoiceitems
      LEFT JOIN smartdc.ufds  AS ufds ON ("AccountNumber") = ufds.uuid
      LEFT JOIN smartdc.zuora_customers  AS zuora_customers ON zuora_customers.accountnumber = ("AccountNumber")

      GROUP BY 1,DATE_TRUNC('month', zinvoiceitems."ChargeDate" )
      ) as table_a
       ;;
  }

  measure: count {
    description: "Count of unique customers"
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    description: "The row number from zinvoiceitems joined with ufds, and zuora_customers"
    primary_key: yes
  }

  dimension: email {
    description: "ufds.email"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: charge_month {
    description: "the month derived from the zinvoicesitems.ChargeDate"
    type: date
    sql: ${TABLE}.charge_month ;;
  }

  dimension: total_amount {
    description: "zinvoiceitems.ChargeAmount or 0"
    type: string
    sql: ${TABLE}.total_amount ;;
  }

  dimension: previous_amount {
    description: "total_amount from the previous row"
    type: string
    sql: ${TABLE}.previous_amount ;;
  }

  dimension: is_seemless_sale {
    description: "boolean if previous_amount is 0 and total_amount is != 0 OR previous_amount is null and total_amount is not null"
    type: yesno
    sql: (${previous_amount} = 0 AND ${total_amount} != 0)
    OR  (${previous_amount} is null AND ${total_amount} is not null) ;;
  }

  dimension: change {
    description: "change from prior month"
    type: number
    sql: ${total_amount}-${previous_amount};;
    value_format_name: decimal_2
#     sql: 1.0*(${total_amount}-${previous_amount})/nullif(${previous_amount},0) ;;
#     value_format_name: percent_0
  }

  measure: avg_change {
    description: "Average amount of change"
    type: average
    sql: ${change} ;;
    value_format_name: decimal_2
    drill_fields: [email,previous_amount,total_amount,change]
#     value_format_name: percent_0
  }
  set: detail {
    fields: [email, charge_month, total_amount, previous_amount]
  }
}

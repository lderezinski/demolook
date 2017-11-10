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
    type: date
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

  dimension: is_seemless_sale {
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

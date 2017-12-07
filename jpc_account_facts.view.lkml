include: "joyent_cloud.model.lkml"
view: jpc_account_facts {

    derived_table: {
      explore_source: jpcdaily_spend {
        column: account_number {field: jpcdaily_spend.accountnumber}
        column: total_orders {field: jpcdaily_spend.count}
        column: total_spend {field: jpcdaily_spend.sum_spend}
        column: avg_spend {field: jpcdaily_spend.avg_spend}
      }
    }

    dimension: account_number {
      primary_key: yes
      hidden: yes
    }

    dimension: total_orders {
      type: number
    }

    dimension: total_spend {
      type: number
      value_format_name: usd
    }

    dimension: total_spend_tier {
      type: tier
      tiers: [100,250,500,1000,5000,10000]
      sql: ${total_spend} ;;
      style: integer
    }

    dimension: avg_spend {
      description: "This is average spend per order."
      type: number
      value_format_name: usd
    }

    dimension: account_health_score {
      sql: case
          when ${total_spend} > 1000 then 100
          when ${total_spend} > 20 then 70
          else 30
          end;;
    }

    dimension: account_health {
      type: string
      sql: CASE
        WHEN ${account_health_score} < 50 THEN '1. At Risk'
        WHEN ${account_health_score} < 71 THEN '2. Standard'
        WHEN ${account_health_score} >= 71 THEN '3. Safe'
        ELSE 'NA'
      END
       ;;
      html: {% if value == '1. At Risk' %}
        <div style="color: black; background-color: #dc7350; margin: 0; border-radius: 5px; text-align:center">{{ value }}</div>
      {% elsif value == '2. Standard' %}
        <div style="color: black; background-color: #e9b404; margin: 0; border-radius: 5px; text-align:center">{{ value }}</div>
      {% else %}
        <div style="color: black; background-color: #49cec1; margin: 0; border-radius: 5px; text-align:center">{{ value }}</div>
      {% endif %}
      ;;
    }


#### Comparitor logic ####
    filter: account_select {
      view_label: "Account comparisons"
      suggest_explore: zuora_customers
      suggest_dimension: zuora_customers.accountnumber
    }

    dimension: account_comparitor {
      view_label: "Account comparisons"
      description: "Use in conjunction with rep select filter to compare to other sales reps"
      sql: CASE
        WHEN {% condition account_select %} ${account_number} {% endcondition %}
          THEN '1 - ' || ${account_number}
      ELSE '2 - Rest of Accounts'
      END
       ;;
    }

    measure: overall_spend_comparitor {
      description: "Use this when comparing groups against each other"
      view_label: "Account comparisons"
      type: average
      sql: ${total_spend} ;;
    }
  }

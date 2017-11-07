view: jpcdaily_spend {
    sql_table_name: smartdc.zdailyspend ;;

    dimension: accountnumber {
      type: string
      sql: ${TABLE}.accountnumber ;;
      link: {
        label: "{{ value }} Lookup DB"
        url: "/dashboards/17?Account%20Number={{ value }}"
      }
    }

    dimension_group: day {
      type: time
      timeframes: [
        raw,
        date,
        week,
        month,
        quarter,
        year
      ]
      convert_tz: no
      datatype: date
      sql: ${TABLE}.day ;;
    }

    dimension: is_yesterday {
      type: yesno
      sql: (${day_date}  = CURRENT_DATE - INTERVAL '1 days') ;;
    }

    dimension: two_days_ago {
      type: yesno
      sql: (${day_date}  = CURRENT_DATE - INTERVAL '2 days') ;;
    }

  dimension: is_week_ago {
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '1 weeks') ;;
  }
  dimension: four_weeks_ago {
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '4 weeks') ;;
    }
  dimension: eight_weeks_ago {
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '8 weeks') ;;
  }
  dimension: twelve_weeks_ago {
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '12 weeks') ;;
  }
  dimension: sixteen_weeks_ago {
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '16 weeks') ;;
  }
    dimension: jpcspend {
      type: number
      sql: ${TABLE}.jpcspend ;;
    }

    dimension: jpctotal {
      type: number
      sql: ${TABLE}.jpctotal ;;
    }

    dimension: spend {
      type: number
      sql: ${TABLE}.spend ;;
      value_format_name: usd
    }

    dimension: total {
      type: number
      sql: ${TABLE}.total ;;
    }

    dimension: months_since_signup{
      sql: round(DATE_PART('day', ${day_raw} - ${zuora_customers.createddate_raw})/30);;
      value_format: "#"
    }

    measure: count {
      type: count
      drill_fields: []
    }
    measure: monthToDate {
      type:  sum
      sql: ${jpcspend} ;;
      drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
    }
    measure: notJPCSpend {
      type: number
      sql: ${total} - ${jpcspend} ;;
      drill_fields: [accountnumber,day_date]
    }
    measure: sum_spend {
      type: sum
      sql: ${spend} ;;
      drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
      value_format_name: usd
    }

    measure: avg_spend {
      description: "This is the average spend"
      type: average
      sql: ${spend} ;;
      value_format_name: usd
    }

    measure: sum_spend_yesterday {
      type: sum
      sql: ${spend} ;;
      filters: {
        field: is_yesterday
        value: "Yes"
      }
      value_format_name: usd
      drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
    }

    measure: sum_spend_2_days_ago {
      type: sum
      sql: ${spend} ;;
      filters: {
        field: two_days_ago
        value: "Yes"
      }
      value_format_name: usd
      drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
    }

    measure: difference {
      description: "The difference between yesterday and 2 days ago"
      type: number
      sql: ${sum_spend_yesterday}- ${sum_spend_2_days_ago};;
      value_format_name: usd
      drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
    }

 }
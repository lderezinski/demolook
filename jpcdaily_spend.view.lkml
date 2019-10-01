view: jpcdaily_spend {
    sql_table_name: smartdc.zdailyspend ;;

  dimension: primary_compound_key{
    description: "Primary key accountnumber + day"
    primary_key: yes
    hidden: yes
    sql:  ${TABLE}.accountnumber || '-' ||  ${TABLE}.day;;
  }
    dimension: accountnumber {
      description: "UFDS UUID account number"
      type: string
      sql: ${TABLE}.accountnumber ;;
      link: {
        label: "{{ value }} Lookup DB"
        url: "/dashboards/17?Account%20Number={{ value }}"
      }
    }

    dimension_group: day {
      description: "The date the spend is for"
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
      description: "Boolean is day equal to yesterday"
      type: yesno
      sql: (${day_date}  = CURRENT_DATE - INTERVAL '1 days') ;;
    }

    dimension: two_days_ago {
      description: "Boolean is day equal to 2 days ago"
      type: yesno
      sql: (${day_date}  = CURRENT_DATE - INTERVAL '2 days') ;;
    }

  dimension: is_week_ago {
    description: "Boolean is day equal to a week ago"
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '1 weeks') ;;
  }
  dimension: four_weeks_ago {
    description: "Boolean is day equal to 4 weeks ago"
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '4 weeks') ;;
    }
  dimension: eight_weeks_ago {
    description: "Boolean is day equal to 8 weeks ago"
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '8 weeks') ;;
  }
  dimension: twelve_weeks_ago {
    description: "Boolean is day equal to 12 weeks ago"
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '12 weeks') ;;
  }
  dimension: sixteen_weeks_ago {
    description: "Boolean is day equal to 16 weeks ago"
    type: yesno
    sql: (${day_date}  = CURRENT_DATE - INTERVAL '16 weeks') ;;
  }
    dimension: jpcspend {
      description: "The jpc spend for the day in question"
      type: number
      sql: ${TABLE}.jpcspend ;;
      value_format_name: usd
    }

    dimension: jpctotal {
      description: "The jpc total for the day in question"
      type: number
      sql: ${TABLE}.jpctotal ;;
      value_format_name: usd
    }

    dimension: spend {
      description: "the spend for the day in question"
      type: number
      sql: ${TABLE}.spend ;;
      value_format_name: usd
    }

    dimension: total {
      description: "The total spend for the day in question"
      type: number
      sql: ${TABLE}.total ;;
    }

    dimension: months_since_signup{
      description: "How many months ago was this account created"
      sql: round(DATE_PART('day', ${day_raw} - ${zuora_customers.createddate_raw})/30);;
      value_format: "#"
    }

    measure: count {
      description: "Number of distinct objects returned in query"
      type: count
      drill_fields: []
    }
    measure: jpcmonthToDate {
      description: "How much spend in JPC for the current month"
      type:  sum_distinct
      sql: ${jpcspend} ;;
      drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
      value_format_name: usd
    }

  measure: monthToDate {
    description: "Month to date total spend"
    type:   sum_distinct
    sql: ${spend} ;;
    drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
    value_format_name: usd
  }
    measure: notJPCSpend {
      description: "How much spend outside of JPC"
      type: number
      sql: ${total} - ${jpcspend} ;;
      drill_fields: [accountnumber,day_date]
      value_format_name: usd
    }
    measure: sum_spend {
      description: "Summation of spend"
      type: sum
      sql: ${spend} ;;
      drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
      value_format_name: usd
    }

    measure: avg_spend {
      description: "This is the average spend"
      type: average
      sql: ${spend} ;;
      drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
      value_format_name: usd
    }
  measure: max_spend {
    description: "This is the max spend"
    type: max
    sql: ${spend} ;;
    drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
    value_format_name: usd
  }
  measure: min_spend {
    description: "This is the min spend"
    type: min
    sql: ${spend} ;;
    drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
    value_format_name: usd
  }
  measure: median_spend {
    description: "This is the max spend"
    type: median
    sql: ${spend} ;;
    drill_fields: [accountnumber,day_date,jpcspend,jpctotal,total,spend]
    value_format_name: usd
  }
    measure: sum_spend_yesterday {
      description: "Sum spend of yesterday"
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
      description: "Sum spend for two days ago"
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

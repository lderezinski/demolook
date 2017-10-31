view: ufds {
  sql_table_name: smartdc.ufds ;;

  dimension: approved_for_provisioning {
    type: yesno
    sql: ${TABLE}.approved_for_provisioning ;;
  }

  dimension: cn {
    type: string
    sql: ${TABLE}.cn ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: givenname {
    type: string
    sql: ${TABLE}.givenname ;;
  }

  dimension: login {
    type: string
    sql: ${TABLE}.login ;;
  }

  dimension: sn {
    type: string
    sql: ${TABLE}.sn ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  measure: count {
    type: count
    drill_fields: [givenname]
  }
}

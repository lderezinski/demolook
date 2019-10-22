view: ufds {
  sql_table_name: smartdc.ufds ;;

  dimension: approved_for_provisioning {
    description: "UFDS.approved_for_provisioning"
    type: yesno
    sql: ${TABLE}.approved_for_provisioning ;;
  }

  dimension: cn {
    description: "UFDS.cn"
    type: string
    sql: coalesce(${TABLE}.cn,${givenname} || ' '  || ${sn}) ;;
  }

  dimension: company {
    description: "UFDS.company"
    type: string
    sql: coalesce(${TABLE}.company,${TABLE}.cn) ;;
  }

  dimension_group: created {
    description: "Date records created in UFDS"
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
    description: "UFDS.email"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: givenname {
    description: "UFDS.givenname (first name)"
    type: string
    sql: ${TABLE}.givenname ;;
  }

  dimension: login {
    description: "UFDS.login"
    type: string
    sql: ${TABLE}.login ;;
  }

  dimension: sn {
    description: "UFDS.sn (last name)"
    type: string
    sql: ${TABLE}.sn ;;
  }

  dimension: uuid {
    description: "UFDS.uuid Account number"
    type: string
    sql: ${TABLE}.uuid ;;
    primary_key: yes
  }

dimension: grouped_name {
  description: "Groupname or UFDS.login"
  type: string
  sql: ${TABLE}.grouped_name ;;
  drill_fields: [uuid]
}
  dimension: display_name {
    description: "UFDS.company (UFDS.login)"
    type: string
    sql: CONCAT( ${company}, '(',${login},')') ;;
  }
  measure: count_distinct_groups {
    description: "Count of distinct group names"
    type: count_distinct
    sql: ${grouped_name} ;;
    drill_fields: [givenname]
  }
  measure: count_distinct {
    description: "Number of distinct objects returned in query"
    type: count_distinct
    sql: ${uuid} ;;
    drill_fields: [givenname]
  }
  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [givenname]
  }

}

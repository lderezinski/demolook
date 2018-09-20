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

dimension: grouped_name {
  type: string
  sql: CASE WHEN ${login} = 'spassdev' THEN 'Pass'
            WHEN ${login} = 'spassprd' THEN 'Pass'
            WHEN ${login} = 'spasspre' THEN 'Pass'
            WHEN ${login} = 'spassstg' THEN 'Pass'

            WHEN ${login} = 'scloud.prd' THEN 'SCloud'
            WHEN ${login} = 'cloudpi' THEN 'SCloud'
            WHEN ${login} = 'nereid' THEN 'SCloud'
            WHEN ${login} = 'samsung.ops' THEN 'SCloud'
            WHEN ${login} = 'scloud.dev' THEN 'SCloud'
            WHEN ${login} = 'samsung.stg' THEN 'SCloud'

            WHEN ${login} = 'griffin_srcb' THEN 'Griffin'
            WHEN ${login} = 'griffin' THEN 'SCloud'
            WHEN ${login} = 'griffin_dev' THEN 'SCloud'
            WHEN ${login} = 'griffin_srpol' THEN 'SCloud'
            WHEN ${login} = 'griffin_stage' THEN 'SCloud'
            ELSE ${login} END ;;
}
  dimension: display_name {
    type: string
    sql: CONCAT( ${company}, '(',${login},')') ;;
  }

  measure: count {
    type: count
    drill_fields: [givenname]
  }

}

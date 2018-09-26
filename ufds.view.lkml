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
    primary_key: yes
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

            WHEN ${login} = 'nereid' THEN 'ceres'

            WHEN ${login} = 'spcportalstaging' then 'SPCPortal'
            WHEN ${login} = 'spcportalprod' then 'SPCPortal'
            WHEN ${login} = 'spcportaladmin' then 'SPCPortal'
            WHEN ${login} = 'webconsoledev' then 'SPCPortal'

            WHEN ${login} = 'ryan.kitchen' then 'Joyent QA'
            WHEN ${login} = 'angela.fong' then 'Joyent QA'
            WHEN ${login} = 'khangngu' then 'Joyent QA'

            WHEN ${login} = 'kiener' then 'Joyent QA'
            WHEN ${login} = 'wcp' then 'Joyent QA'
            WHEN ${login} = 'cody.mello' then 'Joyent QA'
            WHEN ${login} = 'akp140030' then 'Joyent QA'
            WHEN ${login} = 'joyent_acceptance_tester' then 'Joyent QA'


            WHEN ${login} = 'bbennett' then 'joyent_ops'
            WHEN ${login} = 'joyent_cloudapi_health' then 'joyent_ops'

            ELSE ${login} END ;;

            drill_fields: [uuid]
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

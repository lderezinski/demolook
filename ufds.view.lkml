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
  sql: CASE WHEN ${login} = 'spassdev' THEN 'Samsung Pass'
            WHEN ${login} = 'spassprd' THEN 'Samsung Pass'
            WHEN ${login} = 'spasspre' THEN 'Samsung Pass'
            WHEN ${login} = 'spassstg' THEN 'Samsung Pass'
            WHEN ${login} = 'opsvctraining' THEN 'Samsung Pass'

            WHEN ${login} = 'samsungmax' THEN 'Samsung Max'

            WHEN ${login} = 'scloud.dev' THEN 'Samsung Cloud'
            WHEN ${login} = 'scloud.stg' THEN 'Samsung Cloud'
            WHEN ${login} = 'scloud.prd' THEN 'Samsung Cloud'
            WHEN ${login} = 'samsung.ops' THEN 'Samsung Cloud'


            WHEN ${login} = 'neptune' THEN 'PI Team'
            WHEN ${login} = 'mediator' THEN 'PI Team'
            WHEN ${login} = 'ceres' THEN 'PI Team'
            WHEN ${login} = 'nereid' THEN 'PI Team'
            WHEN ${login} = 'proteus' THEN 'PI Team'
            WHEN ${login} = 'griffin_srcb' THEN 'PI Team'
            WHEN ${login} = 'griffin' THEN 'PI Team'
            WHEN ${login} = 'griffin_dev' THEN 'PI Team'
            WHEN ${login} = 'griffin_srpol' THEN 'PI Team'
            WHEN ${login} = 'griffin_stage' THEN 'PI Team'
            WHEN ${login} = 'hermes' THEN 'PI Team'
            WHEN ${login} = 'cloudpi' THEN 'PI Team'
            WHEN ${login} = 'ucci' THEN 'PI Team'
            WHEN ${login} = 'cds' THEN 'PI Team'

            WHEN ${login} = 'spcportalstaging' then 'SPC Portal'
            WHEN ${login} = 'spcportalprod' then 'SPC Portal'
            WHEN ${login} = 'spcportaladmin' then 'SPC Portal'
            WHEN ${login} = 'webconsoledev' then 'SPC Portal'

            WHEN ${login} = 'ryan.kitchen' then 'Joyent QA'
            WHEN ${login} = 'angela.fong' then 'Joyent QA'
            WHEN ${login} = 'khangngu' then 'Joyent QA'

            WHEN ${login} = 'kiener' then 'Joyent QA'
            WHEN ${login} = 'wcp' then 'Joyent QA'
            WHEN ${login} = 'cody.mello' then 'Joyent QA'
            WHEN ${login} = 'akp140030' then 'Joyent QA'
            WHEN ${login} = 'joyent_acceptance_tester' then 'Joyent QA'
            WHEN ${login} = 'maxb' then 'Joyent QA'

            WHEN ${login} = 'joyentsup' then 'Joyent Support'

            WHEN ${login} = 'admin' then 'Joyent Ops'
            WHEN ${login} = 'joyent_ops' then 'Joyent Ops'
            WHEN ${login} = 'bbennett' then 'Joyent Ops'
            WHEN ${login} = 'joyent_cloudapi_health' then 'Joyent Ops'

            ELSE ${login} END ;;

            drill_fields: [uuid]
}
  dimension: display_name {
    type: string
    sql: CONCAT( ${company}, '(',${login},')') ;;
  }
  measure: count_distinct_groups {
    type: count_distinct
    sql: ${grouped_name} ;;
    drill_fields: [givenname]
  }
  measure: count_distinct {
    type: count_distinct
    sql: ${uuid} ;;
    drill_fields: [givenname]
  }
  measure: count {
    type: count
    drill_fields: [givenname]
  }

}

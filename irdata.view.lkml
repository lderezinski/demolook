view: irdata {
  sql_table_name: smartdc.irdata ;;

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: followup {
    type: string
    sql: ${TABLE}.followup ;;
  }

  dimension: incticket {
    primary_key: yes
    type: string
    sql: ${TABLE}.incticket ;;
  }

  dimension: irlink {
    type: string
    sql: ${TABLE}.irlink ;;
  }

  dimension_group: jiracreated {
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
    sql: ${TABLE}.jiracreated ;;
  }

  dimension_group: jiraresolved {
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
    sql: ${TABLE}.jiraresolved ;;
  }

  dimension: priorty {
    type: string
    sql: ${TABLE}.priorty ;;
  }

  dimension: reportreq {
    type: yesno
    sql: ${TABLE}.reportreq ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

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
    html:
    {% if irlink  == NULL %}
      No Report
    {% elsif irlink  == "" %}
      No Report
    {% else %}
      <a href="{{ irlink }}">{{ incticket }} report</a>
      {% endif %} ;;
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

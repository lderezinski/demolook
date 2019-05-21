view: incdata {
  sql_table_name: smartdc.incdata ;;

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: detectionrate {
    type: number
    sql: ${TABLE}.detectionrate ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension_group: finalreporttime {
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
    sql: ${TABLE}.finalreporttime ;;
  }

  dimension_group: firstzdticket {
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
    sql: ${TABLE}.firstzdticket ;;
  }

  dimension: followup {
    type: string
    sql: ${TABLE}.followup ;;
  }

  dimension: impact {
    type: string
    sql: ${TABLE}.impact ;;
  }

  dimension_group: incend {
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
    sql: ${TABLE}.incend ;;
  }

  dimension_group: incstart {
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
    sql: ${TABLE}.incstart ;;
  }

  dimension: incstarttojira {
    type: string
    sql: ${TABLE}.incstarttojira ;;
  }

  dimension: incticket {
    type: string
    sql: ${TABLE}.incticket ;;
  }

  dimension_group: initialnottime {
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
    sql: ${TABLE}.initialnottime ;;
  }

  dimension: irlink {
    type: string
    sql: ${TABLE}.irlink ;;
    html:
    {% if value  == null %}
    <font color="grey">No Report</font>
    {% elsif value  == '' %}
    <font color="grey">No Report</font>
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

  dimension: less15notice {
    type: yesno
    sql: ${TABLE}.less15notice ;;
  }

  dimension_group: pagerdutytime {
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
    sql: ${TABLE}.pagerdutytime ;;
  }

  dimension: priorty {
    type: string
    sql: ${TABLE}.priorty ;;
  }

  dimension: reportreq {
    type: yesno
    sql: ${TABLE}.reportreq ;;
  }

  dimension: rollavgdetectrate {
    type: number
    sql: ${TABLE}.rollavgdetectrate ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

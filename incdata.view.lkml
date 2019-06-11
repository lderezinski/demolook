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

  dimension_group: finalreportsent {
    type: time
    timeframes: [
      raw,
      time,
      date,
            hour,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.finalreporttime ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }



  dimension_group: firstzdticket {
    type: time
    timeframes: [
      raw,
      time,
      date,
            hour,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.firstzdticket ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: followup {
    type: string
    sql: ${TABLE}.followup ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: impact {
    type: string
    sql: ${TABLE}.impact ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension_group: incend {
    type: time
    timeframes: [
      raw,
      time,
            hour,
      date,
      week,
      month,
      month_num,
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
      hour,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.incstart ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

dimension: instart_fiscalhalf {
  type: string
  sql: CASE
            WHEN ${incstart_month_num} < 7 then concat(${incstart_year}::text,'-H1')
            ELSE concat(${incstart_year}::text,'-H2')
       END;;
  drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]

}
  dimension: incstarttojira {
    type: number
    sql: ${TABLE}.incstarttojira ;;
    html:
    {% if value > 15.0 %}
    <font color="red">{{ rendered_value }}</font>
    {% else %}
    {{ rendered_value }}
    {% endif %} ;;
    value_format_name:  decimal_2
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: incstarttojira_tier{
    type: tier
    tiers: [16,31,46,61]
    style: relational
    sql: ${incstarttojira};;
  }

  dimension: incticket {
    type: string
    sql: ${TABLE}.incticket ;;
    html: <a href="https://jira.joyent.us/browse/{{value}}">{{value}}</a> ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: detected {
    type: yesno
    sql: ${TABLE}.detected ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension_group: initialnottime {
    type: time
    timeframes: [
      raw,
      time,
            hour,
      date,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.initialnottime ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
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
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension_group: jiracreated {
    type: time
    timeframes: [
      raw,
      time,
      date,
            hour,
      week,
      month,
          month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.jiracreated ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension_group: jiraresolved {
    type: time
    timeframes: [
      raw,
      time,
      date,
            hour,
      week,
      month,
          month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.jiraresolved ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
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
            hour,
      date,
      week,
      month,
          month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.pagerdutytime ;;
  }

  dimension: priorty {
    type: string
    sql: ${TABLE}.priorty ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
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
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: irdeliverytime {
    type: number
    sql:  ${TABLE}.irdeliverytime ;;
    value_format_name:  decimal_2
    html:
      {% if value > 2.0 %}
        <font color="red">{{ rendered_value }}</font>
        {% else %}
        {{ rendered_value }}
      {% endif %} ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: irdeliverytime_tier{
    type: tier
    tiers: [2,3,4,5]
    style: relational
    sql: ${irdeliverytime};;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }


  dimension: ontime {
    type: yesno
    sql: ${TABLE}.irdeliverytime <= 2.0001 ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }


  measure: count {
    type: count
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  measure: sumincstarttojira {
    type:  sum
    sql: ${incstarttojira};;

    value_format_name:  decimal_2
    html:
      {% if value > 15.0 %}
        <font color="red">{{ rendered_value }}</font>
        {% else %}
        {{ rendered_value }}
      {% endif %} ;;
  }
  measure: sumirdeliverytime {
    type:  sum
    sql: ${irdeliverytime};;

    value_format_name:  decimal_2
    html:
      {% if value > 2.0 %}
        <font color="red">{{ rendered_value }}</font>
        {% else %}
        {{ rendered_value }}
      {% endif %} ;;
  }
}

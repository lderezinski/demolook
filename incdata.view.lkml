view: incdata {
  # this table is created hourly by scraping this google sheet
  # https://docs.google.com/spreadsheets/d/1EZdqbhcz8RpURAJhwqClSHv9JZ-YQg8iUf43VVV90kc/edit#gid=1350110530

  sql_table_name: smartdc.incdata ;;

  dimension: description {
    description: "Description entry from Inc Data tab"
    type: string
    sql: ${TABLE}.description ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: detectionrate {
    description: "Rolling Average of detection"
    type: number
    sql: ${TABLE}.detectionrate ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: duration {
    description: "Duration calcuated from Inc Data tab"
    type: number
    sql: ${TABLE}.duration ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension_group: finalreportsent {
    description: "timestamp when final report was sent"
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
    description: "timestamp when first customer support ticket was filed"
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
    description: "'Follow-up / Comments' from the IncData tab"
    type: string
    sql: ${TABLE}.followup ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: impact {
    description: "Impact of the Incident"
    type: string
    sql: ${TABLE}.impact ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension_group: incend {
    description: "timestamp of the incident end time"
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
    description: "timestamp of the start of Incident"
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
  description: "Fiscal half of the year the incstart falls into"
  type: string
  sql: CASE
            WHEN ${incstart_month_num} < 7 then concat(${incstart_year}::text,'-H1')
            ELSE concat(${incstart_year}::text,'-H2')
       END;;
  drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]

}
  dimension: incstarttojira {
    description: "time between incendent start time and JIRA created"
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

  dimension: incstarttojira_tier {
    description: "Time between incedent start time and JIRA created tier (16.31.46,61+)"
    type: tier
    tiers: [16,31,46,61]
    style: relational
    sql: ${incstarttojira};;
  }

  dimension: incticket {
    description: "JIRA INC ticket number"
    type: string
    sql: ${TABLE}.incticket ;;
    html: <a href="https://jira.joyent.us/browse/{{value}}">{{value}}</a> ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: detected {
    description: "Boolean Did Joyent find the issue before customer?"
    type: yesno
    sql: ${TABLE}.detected ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension_group: initialnottime {
    description: "timestamp of incident notice sent "
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
    description: "Link to the incident report if available"
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
    description: "timestamp JIRA was created"
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
    description: "timestamp JIRA was resolved"
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
    description: "Boolean was notice sent out within 15 minutes of the inc starttime"
    type: yesno
    sql: ${TABLE}.less15notice ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension_group: pagerdutytime {
    description: "timestamp of the pager duty alert"
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
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: priorty {
    description: "priorty of the incident"
    type: string
    sql: ${TABLE}.priorty ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: reportreq {
    description: "Boolean is a report required for this incident"
    type: yesno
    sql: ${TABLE}.reportreq ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: rollavgdetectrate {
    description: "Rolling avgerage of detecting incidents before customer"
    type: number
    sql: ${TABLE}.rollavgdetectrate ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: type {
    description: "Type of incident (manta, object store, triton, etc)"
    type: string
    sql: ${TABLE}.type ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  dimension: irdeliverytime {
    description: "number of days it took to deliver the report"
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
    description: "Number of days it took to deliver the report tier (2,3,4,5+)"
    type: tier
    tiers: [2,3,4,5]
    style: relational
    sql: ${irdeliverytime};;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }


  dimension: ontime {
    description: "Boolean was the report delivered with in 2 days"
    type: yesno
    sql: ${TABLE}.irdeliverytime <= 2.0001 ;;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }


  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
  }

  measure: sumincstarttojira {
    description: "Number of minutes between incident start time and jira creation time for all incidents selected"
    type:  sum
    sql: ${incstarttojira};;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
    value_format_name:  decimal_2
    html:
      {% if value > 15.0 %}
        <font color="red">{{ rendered_value }}</font>
        {% else %}
        {{ rendered_value }}
      {% endif %} ;;
  }
  measure: sumirdeliverytime {
    description: "Number of minutes between incident report delivery time for all incidents selected"
    type:  sum
    sql: ${irdeliverytime};;
    drill_fields: [incend_time,incstart_time,incticket,description,priorty,jiracreated_time,irlink]
    value_format_name:  decimal_2
    html:
      {% if value > 2.0 %}
        <font color="red">{{ rendered_value }}</font>
        {% else %}
        {{ rendered_value }}
      {% endif %} ;;
  }
}

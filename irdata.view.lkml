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

  dimension: priorty {
    type: string
    sql: ${TABLE}.priorty ;;
  }

  dimension: reportreq {
    type: yesno
    sql: ${TABLE}.reportreq ;;
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
}

  dimension: irdeliverytime_tier{
    type: tier
    tiers: [2,3,4,5]
    style: interval
    sql: ${irdeliverytime};;
  }

  dimension_group: finalreportsent {
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
    sql: ${TABLE}.finalreportsent ;;
  }


  dimension: ontime {
    type: yesno
    sql: ${TABLE}.irdeliverytime <= 2.0 ;;
  }


  measure: count {
    type: count
    drill_fields: []
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

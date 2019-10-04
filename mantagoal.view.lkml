view: mantagoal {
  sql_table_name: capacity.mantagoal ;;


  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date  || ${TABLE}.region;;
  }

  dimension_group: date {
    description: ""
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: goal {
    description: ""
    type: number
    sql: ${TABLE}.goal ;;
  }

  dimension: region {
    description: ""
    type: string
    sql: ${TABLE}.region ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: goalsum {
    description: ""
    type: sum
    sql: ${goal} ;;
  }
}

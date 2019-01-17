view: mantagoal {
  sql_table_name: capacity.mantagoal ;;


  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.date.date  || ${TABLE}.region;;
  }


  dimension_group: date {
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

  dimension_group: enddate {
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
    sql: ${TABLE}.enddate ;;
  }

  dimension: goal {
    type: number
    sql: ${TABLE}.goal ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: goalsum {
    type: sum
    sql: ${goal} ;;
  }
}

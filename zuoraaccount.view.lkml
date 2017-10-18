view: zuoraaccount {
  sql_table_name: public.zuoraaccount ;;

  dimension: account_number {
    type: string
    sql: ${TABLE}.AccountNumber ;;
    link: {
      label: "{{ value }} Lookup DB"
      url: "/dashboards/3?Account%20Number={{ value }}"
    }
  }

  dimension: batch {
    type: string
    sql: ${TABLE}.Batch ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.CreatedDate ;;
  }

  dimension: stateprovince {
    type: string
    sql: ${TABLE}."State-Province" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

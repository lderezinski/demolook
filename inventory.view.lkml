view: inventory {
  sql_table_name: capacity.inventory ;;

  dimension: az {
    type: string
    sql: ${TABLE}."AZ" ;;
  }

  dimension: build {
    type: string
    sql: ${TABLE}."Build" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."Region" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}."Sku" ;;
  }

  dimension: total_nodes {
    type: number
    sql: ${TABLE}."TotalNodes" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: sum_nodes {
    type: sum
    sql: ${total_nodes} ;;
  }
}

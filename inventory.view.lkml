view: inventory {
  sql_table_name: capacity.inventory ;;

  dimension: az {
    description: "Name of the avalibility zone"
    type: string
    sql: ${TABLE}.AZ ;;
  }

  dimension: build {
    description: "Build number"
    type: string
    sql: ${TABLE}.Build ;;
  }

  dimension: region {
    description: "Name of the region"
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: sku {
    description: "Sku of the computer"
    type: string
    sql: ${TABLE}.Sku ;;
  }

  dimension: total_nodes {
    description: "number of nodes"
    type: number
    sql: ${TABLE}.TotalNodes ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: sum_nodes {
    description: "sum of total nodes"
    type: sum
    sql: ${total_nodes} ;;
  }
}

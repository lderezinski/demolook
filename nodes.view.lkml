view: nodes {
  sql_table_name: capacity.nodes ;;


  dimension: hostname {
    type: string
    sql: ${TABLE}."Hostname" ;;
  }
  dimension: product {
    type: string
    sql: ${TABLE}."Product" ;;
  }
  dimension: trait {
    type: string
    sql: ${TABLE}."trait" ;;
  }
  dimension: rackPos {
    type: string
    sql: ${TABLE}."rack" ;;
  }
  dimension: AZ {
    type: string
    sql: ${TABLE}."Region" ;;
  }
  dimension: region {
    type: string
    sql: left(${AZ}, -1) ;;
  }
  dimension: serial {
    type: string
    sql: ${TABLE}."serialNo" ;;
  }


  dimension: setup {
    type: yesno
    sql: ${TABLE}."setup" ;;
  }
  dimension: ram {
    type: string
    sql: ${TABLE}."ram" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}."sku" ;;
  }
  dimension: rack {
    type: string
    sql: left(${rackPos},-3) ;;
  }
  measure: count {
    type: count
    drill_fields: []
  }
}

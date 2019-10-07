view: server_sku {
  sql_table_name: capacity.server_sku ;;

  dimension: common_name {
    description: "The server's common name"
    type: string
    sql: ${TABLE}."CommonName" ;;
  }

  dimension: old_product {
    description: "previous product sku number"
    type: string
    sql: ${TABLE}."OldProduct" ;;
  }

  dimension: old_sku {
    description: "previous product sku name"
    type: string
    sql: ${TABLE}."OldSku" ;;
  }

  dimension: product {
    description: "Server current sku"
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: short_name {
    description: "Server short name HA, HB, etc"
    type: string
    sql: ${TABLE}."ShortName" ;;
  }

  dimension: sku {
    description: "the XXX-XXXX-XXX number"
    type: string
    sql: ${TABLE}."Sku" ;;
  }

  dimension: vendor {
    description: "Dell or Supermicro"
    type: string
    sql: ${TABLE}."Vendor" ;;
  }

  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: [short_name, common_name]
  }
}

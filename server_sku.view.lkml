view: server_sku {
  sql_table_name: capacity.server_sku ;;

  dimension: common_name {
    type: string
    sql: ${TABLE}."CommonName" ;;
  }

  dimension: old_product {
    type: string
    sql: ${TABLE}."OldProduct" ;;
  }

  dimension: old_sku {
    type: string
    sql: ${TABLE}."OldSku" ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}."Product" ;;
  }

  dimension: short_name {
    type: string
    sql: ${TABLE}."ShortName" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}."Sku" ;;
  }

  dimension: vendor {
    type: string
    sql: ${TABLE}."Vendor" ;;
  }

  measure: count {
    type: count
    drill_fields: [short_name, common_name]
  }
}

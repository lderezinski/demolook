view: dictionary {
  sql_table_name: metadata.dictionary ;;

  dimension: description {
    type: string
    sql: REPLACE(${TABLE}."Description",'\','') ;;
  }

  dimension: field_name {
    type: string
    sql: ${TABLE}."FieldName" ;;
  }

  dimension: field_type {
    type: string
    sql: ${TABLE}."FieldType" ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}."Model" ;;
  }

  dimension: sql {
    type: string
    sql:REPLACE( ${TABLE}."SQL",'\','') ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}."Type" ;;
  }

  dimension: view_name {
    type: string
    sql: ${TABLE}."ViewName" ;;
  }

  measure: count {
    type: count
    drill_fields: [view_name, field_name]
  }
}

view: images {
  sql_table_name: smartdc.images ;;

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql:${TABLE}.uuid || ${TABLE}.version || ${TABLE}.owner
  }
  dimension: dcgroup {
    type: string
    sql: ${TABLE}.dcgroup ;;
  }
  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: owner {
    type: string
    sql: ${TABLE}.owner ;;
  }

  dimension: public {
    type: yesno
    sql: ${TABLE}.public ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: v {
    type: number
    sql: ${TABLE}.v ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}

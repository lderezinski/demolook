
view: ram_values {
  derived_table: {
    sql: select 0.125 as value union
      select 0.25 as value union
      select 0.5 as value union
      select 0.75 as value union
      select 1 as value union
      select 2 as value union
      select 4 as value union
      select 8 as value union
      select 16 as value union
      select 32 as value union
      select 64 as value union
      select 80 as value union
      select 128 as value union
      select 220 as value
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  set: detail {
    fields: [value]
  }
}

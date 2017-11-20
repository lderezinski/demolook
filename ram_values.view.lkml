
view: ram_values {
  derived_table: {
    sql: select '0.125' as value union
      select '0.250' as value union
      select '0.500' as value union
      select '0.750' as value union
      select '1.000' as value union
      select '2.000' as value union
      select '4.000' as value union
      select '8.000' as value union
      select '16.000' as value union
      select '32.000' as value union
      select '64.000' as value union
      select '80.000' as value union
      select '128.000' as value union
      select '220.000' as value
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  set: detail {
    fields: [value]
  }
}

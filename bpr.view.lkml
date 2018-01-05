view: bpr {
  sql_table_name: zuora.bpr ;;

  dimension: account_number {
    type: string
    sql: ${TABLE}."AccountNumber" ;;
  }

  dimension: charge_amount {
    type: number
    sql: ${TABLE}."ChargeAmount" ;;
  }

  dimension_group: charge {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."ChargeDate" ;;
  }

  dimension: charge_type {
    type: string
    sql: ${TABLE}."ChargeType" ;;
  }

  dimension: datacenter {
    type: string
    sql: ${TABLE}."Datacenter" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."Name" ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}."Quantity" ;;
  }

  dimension_group: service_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."ServiceEndDate" ;;
  }

  dimension_group: service_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."ServiceStartDate" ;;
  }

  dimension: uom {
    type: string
    sql: ${TABLE}."UOM" ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}

view: bpr {
  sql_table_name: zuora.bpr ;;

  dimension: account_number {
    description: "ufds uuid account number"
    type: string
    sql: ${TABLE}.AccountNumber ;;
  }

  dimension: charge_amount {
    description: "USD charge amount"
    type: number
    sql: ${TABLE}.ChargeAmount ;;
  }

  dimension_group: charge {
    description: "Timestamp for the charge"
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
    sql: ${TABLE}.ChargeDate ;;
  }

  dimension: charge_type {
    description: "Charge type from Zuora"
    type: string
    sql: ${TABLE}.ChargeType ;;
  }

  dimension: datacenter {
    description: "JPC data center"
    type: string
    sql: ${TABLE}.Datacenter ;;
  }

  dimension: name {
    description: "Zuora subscription name"
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: quantity {
    description: "Zuora quanity of items"
    type: number
    sql: ${TABLE}.Quantity ;;
  }

  dimension_group: service_end {
    description: "Timestamp for service end time"
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
    sql: ${TABLE}.ServiceEndDate ;;
  }

  dimension_group: service_start {
    description: "Timestamp for service start time"
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
    sql: ${TABLE}.ServiceStartDate ;;
  }

  dimension: uom {
    description: "Unit of Measure from Zuora"
    type: string
    sql: ${TABLE}.UOM ;;
  }

  measure: count {
    description: "Count of billing preview records"
    type: count
    drill_fields: [name]
  }
  measure: total_quant {
    description: "Sum of quanities"
    type:  sum
    sql: ${quantity} ;;
  }
  measure: total_spend {
    description: "sum of spend"
    type:  sum
    sql: ${charge_amount} ;;
  }


}

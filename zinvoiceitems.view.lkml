view: zinvoiceitems {
  sql_table_name: smartdc.zinvoiceitems ;;

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

  dimension: processing_type {
    type: string
    sql: ${TABLE}."ProcessingType" ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}."Quantity" ;;
  }

  dimension_group: service_end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."ServiceEndDate" ;;
  }

  dimension_group: service_start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."ServiceStartDate" ;;
  }

  dimension: sub_uuid {
    type: string
    sql: ${TABLE}."SubUUID" ;;
  }

  dimension: uom {
    type: string
    sql: ${TABLE}."UOM" ;;
  }

dimension: isInstance {
  type: yesno
  sql: split_part(${sub_uuid},'_',1) = 'Compute' OR split_part(${sub_uuid},'_',1) = 'triton' OR split_part(${sub_uuid},'_',1) = 'KVM' ;;
}
  dimension: isManta {
    type: yesno
    sql: split_part(${sub_uuid},'_',1) = 'manta' ;;
  }
  dimension: isImages {
    type: yesno
    sql: split_part(${sub_uuid},'_',1) = 'images' ;;
  }
  dimension: isBW {
    type: yesno
    sql: split_part(${sub_uuid},'_',1) = 'bw' ;;
  }
  dimension: isSupport {
    type: yesno
    sql: split_part(${sub_uuid},'_',1) = 'support' ;;
  }
  measure: count {
    description: "Number of distinct objects returned in query"
    type: count
    drill_fields: []
  }
  measure: total_amount {
    type: sum
    sql: ${charge_amount} ;;
    value_format_name: usd
    drill_fields: []
  }

}

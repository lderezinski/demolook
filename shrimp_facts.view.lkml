view: shrimp_facts {
   # Or, you could make this view a derived table, like this:
   derived_table: {
     sql: SELECT
  upper(cnapi.hostname)  AS cn_name,
  cnapi.model  AS cn_model,
  cnapi.uuid AS uuid,
  cnapi.dcenter  AS dc,
  DATE(cnapi.date ) AS date
FROM smartdc.cnapi  AS cnapi
where cnapi.model like 'Mantis Shrimp%' and upper(cnapi.hostname) like 'MS%'
GROUP BY 1,2,3,4,5
ORDER BY 1
       ;;
    persist_for: "24 hours"
   }

   # Define your dimensions and measures here, like this:
  dimension: compound_primary_key {
    type:  string
    description: "primary key "
    primary_key: yes
    sql: ${TABLE}.uuid  || ${TABLE}.date;;
  }
  dimension: cn_model {
    description: "The CN model short name"
    type: string
    sql: ${TABLE}.cn_model ;;
  }
  dimension_group: date {
    description:"Timestamp when Cnapi data was collected"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }
   dimension: uuid {
     description: "The cnapi uuid"
     type: string
     sql: ${TABLE}.uuid ;;
   }

   dimension: dc {
     description: "The Cnapi Data center name"
     type: string
     sql: ${TABLE}.dc ;;
   }
  dimension: cn_name {
    description: "The Cnapi hostname"
    type: string
    sql: ${TABLE}.cn_name ;;
  }

  measure: count {
    description: "Count of Shrimp_facts objects"
    type: count

  }

 }

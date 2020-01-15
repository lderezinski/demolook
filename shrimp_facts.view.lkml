view: shrimp_facts {
   # Or, you could make this view a derived table, like this:
   derived_table: {
     sql: SELECT
  cnapi."uuid" AS "uuid",
  upper(cnapi."HOSTNAME")  AS "cn_name",
  cnapi."DCENTER"  AS "dc",
  CASE
            WHEN (cnapi."traits"::text) LIKE '%headnode%' THEN 'Headnode'
            WHEN upper((upper(cnapi."HOSTNAME"))) = 'HEADNODE' THEN 'Headnode'
            WHEN left((upper(cnapi."HOSTNAME")),2) = 'HB' THEN
              case WHEN (cnapi."Sku Number") = '600-0025-01 rev 50' THEN 'Hallasan-B (08TB)'
                   WHEN (cnapi."Sku Number") = '600-0025-01 rev 51' THEN 'Hallasan-B (10TB)'
                   WHEN (cnapi."Sku Number") = '600-0036-001' THEN 'Hallasan-B (12TB)'
                  ELSE (cnapi."Sku Number")
              END
  WHEN (cnapi."Sku Number") = '600-0023-001'  THEN 'Hallasan-A'
  WHEN (cnapi."Sku Number") = 'SKU=NotProvided;ModelName=Joyent-Compute-Platform-3301' THEN 'Hallasan-A'
  WHEN (cnapi."Sku Number") = '600-0024-001' THEN 'Hallasan-C (08)'
  WHEN (cnapi."Sku Number") = '600-0026-001' THEN 'Hallasan-C (16)'
  WHEN (cnapi."Sku Number") = '600-0025-001' THEN 'Mantis Shrimp Mk.III (08TB)'
  WHEN (cnapi."Sku Number") = '600-0025-01 rev 50' THEN 'Mantis Shrimp Mk.III (08TB)'
  WHEN (cnapi."Sku Number") = '600-0025-002' THEN 'Mantis Shrimp Mk.III (10TB)'
  WHEN (cnapi."Sku Number") = '600-0025-01 rev 51' THEN 'Mantis Shrimp Mk.III (10TB)'
  WHEN (cnapi."Sku Number") = '600-0028-001' THEN 'Hallasan-B'
  WHEN (cnapi."Sku Number") = '600-0027-001' THEN 'Hallasan-A r2'
  WHEN (cnapi."Sku Number") = '600-0027-01 rev 50' THEN 'Hallasan-A r2'
  WHEN (cnapi."Sku Number") = '600-0032-001' THEN 'Jirisan-A'
  WHEN (cnapi."Sku Number") = '600-0033-001' THEN 'Jirisan-B'
  WHEN (cnapi."Sku Number") = '600-0034-001' THEN 'Jirisan-C (12)'
  WHEN (cnapi."Sku Number") = '600-0035-001' THEN 'Jirisan-C (24)'
  WHEN (cnapi."Sku Number") = '600-0036-001' THEN 'Mantis Shrimp Mk.III.5 (12TB)'
  WHEN (cnapi."Sku Number") = 'To be filled by O.E.M.' THEN
    case WHEN (upper(cnapi."HOSTNAME")) = 'MS701214' THEN 'Mantis Shrimp Mk.III.5 (12TB)'
         WHEN (upper(cnapi."HOSTNAME")) = 'MS819227' THEN 'Mantis Shrimp Mk.III.5 (12TB)'
        ELSE
          'To be filled by O.E.M.'
        END
  WHEN (cnapi."Sku Number") = 'SKU=NotProvided;ModelName=Joyent-Compute-Platform-3302' THEN
    case
      WHEN (coalesce(cnapi."disk pool size G",0)/1024.0) < 10790592 THEN 'Hallasan-C (08)'
      ELSE 'Hallasan-C (16)' END
  WHEN (cnapi."Sku Number") = '085915D9' THEN
     case WHEN left((upper(cnapi."HOSTNAME")),2) = 'HA' THEN 'Hallasan-A r2'
          WHEN left((upper(cnapi."HOSTNAME")),2) = 'MS' THEN 'Mantis Shrimp Mk.III (10TB)'
          ELSE (cnapi."Sku Number")
     END
  ELSE (cnapi."Sku Number")

            END AS "shortname"
FROM smartdc.cnapi  AS cnapi

WHERE (cnapi."DATE"  >= TIMESTAMP '2020-01-01') AND ((cnapi."Model") LIKE '%Shrimp%')
GROUP BY 1,2,3,4
ORDER BY 1
       ;;
    persist_for: "24 hours"
    indexes: ["shortname","uuid","cn_name","dc"]
   }

   # Define your dimensions and measures here, like this:
   dimension: shortName {
     description: "The CN model short name"
     type: string
     sql: ${TABLE}."shortname" ;;
   }

   dimension: uuid {
     description: "The cnapi uuid"
     type: string
     sql: ${TABLE}."uuid" ;;
   }

   dimension: dc {
     description: "The Cnapi Data center name"
     type: string
     sql: ${TABLE}."dc" ;;
   }
  dimension: cn_name {
    description: "The Cnapi hostname"
    type: string
    sql: ${TABLE}."cn_name" ;;
  }

  measure: count {
    description: "Count of Shrimp_facts objects"
    type: count

  }

 }

view: vmapi_jpc_facts {

    derived_table: {
      sql:
SELECT
  CONCAT( ufds.company, '(',ufds.login,')')  AS "customer_display_name",
  ufds.uuid  AS "ufds_uuid",
  vmapi.uuid  AS "vmapi_uuid",
  DATE_PART('day',(DATE(MAX(vmapi.date) ))::TIMESTAMP - (DATE(MIN(vmapi.date) ))::TIMESTAMP )  AS "run_duration",
  DATE(MIN(vmapi.date) ) AS "first_reported_date",
  DATE(MAX(vmapi.date) ) AS "last_reported_date"
FROM smartdc.vmapi  AS vmapi
LEFT JOIN smartdc.ufds  AS ufds ON ufds.uuid=vmapi.owner_uuid
FULL OUTER JOIN smartdc.datacenters  AS datacenters ON datacenters.name = vmapi.datacenter

WHERE (ufds.email NOT LIKE '%joyent.com%' OR ufds.email IS NULL) AND (((datacenters."group") = 'JPC'))
GROUP BY 1,2,3
HAVING
  (COALESCE(COALESCE(CAST( ( SUM(DISTINCT (CAST(FLOOR(COALESCE(vmapi.ram/1024.0 ,0)*(CAST(1000000 AS DOUBLE PRECISION)*1.0)) AS DECIMAL(65,0))) + ('x' || MD5(vmapi.uuid ||  '  ' || vmapi.datacenter || vmapi.owner_uuid  ::varchar))::bit(64)::bigint::DECIMAL(65,0)  *18446744073709551616 + ('x' || SUBSTR(MD5(vmapi.uuid ||  '  ' || vmapi.datacenter || vmapi.owner_uuid  ::varchar),17))::bit(64)::bigint::DECIMAL(65,0) ) - SUM(DISTINCT ('x' || MD5(vmapi.uuid ||  '  ' || vmapi.datacenter || vmapi.owner_uuid  ::varchar))::bit(64)::bigint::DECIMAL(65,0)  *18446744073709551616 + ('x' || SUBSTR(MD5(vmapi.uuid ||  '  ' || vmapi.datacenter || vmapi.owner_uuid  ::varchar),17))::bit(64)::bigint::DECIMAL(65,0)) )  AS DOUBLE PRECISION) / CAST((CAST(1000000 AS DOUBLE PRECISION)) AS DOUBLE PRECISION), 0), 0) > 16)
ORDER BY 4 DESC
    ;;
    }
    dimension: vmapi_uuid {
      type: string
      primary_key: yes
      sql: ${TABLE}.vmapi_uuid ;;
    }
      dimension: ufds_uuid {
        type: string

        sql: ${TABLE}.ufds_uuid ;;
      }
  dimension_group: last_reported_date {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.last_reported_date ;;
  }

    dimension_group: first_reported_date {
      type: time
      timeframes: [date, week, month]
      sql: ${TABLE}.first_reported_date ;;
    }

    dimension: run_duration {
      type: number
      sql: ${TABLE}.run_duration ;;
    }


  measure: count {
    type: count

  }
  measure: durations {
    type: sum
    sql: ${run_duration};;
  }
}

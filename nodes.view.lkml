view: nodes {
  sql_table_name: capacity.nodes ;;


  dimension: hostname {
    type: string
    sql: ${TABLE}."Hostname" ;;
  }
  dimension: product {
    type: string
    sql: ${TABLE}."Product" ;;
  }
  dimension: productno {
    type: string
    sql: right(${product}, 4) ;;
  }
  dimension: shortName {
    type: string
    sql:  CASE
            WHEN ${trait} LIKE '%headnode%' THEN 'Headnode'
            WHEN ${hostname} = 'headnode' THEN 'Headnode'
            ELSE
              CASE
                WHEN ${product} = 'Joyent-Compute-Platform-3101' THEN 'Hallasan-A.r2'
                WHEN ${product} = 'Joyent-Compute-Platform-3301' THEN 'Hallasan-A'
                WHEN ${product} = 'Joyent-Storage-Platform-7201' THEN 'Hallasan-B'
                WHEN ${product} = 'Joyent-Compute-Platform-3302' THEN 'Hallasan-C'
                WHEN ${product} = 'Joyent-Storage-Platform-7001' THEN 'Mantis Shrimp'
                ELSE 'PowerEdge R710/R510/Other'
              END
            END;;
  }

  dimension: role {
    type: string
    sql:  CASE
            WHEN ${trait} LIKE '%headnode%' THEN 'Headnode'
            WHEN ${hostname} = 'headnode' THEN 'Headnode'
            ELSE
              CASE
                WHEN ${trait} LIKE '%manta%'  THEN 'Manta'
                WHEN ${trait} LIKE '%qa_true%' THEN 'QA'
                WHEN ${trait} LIKE '%bhyve_true%' THEN 'bhyve'
                WHEN ${trait} LIKE '%CTF_true%' THEN 'CTF'
                ELSE 'Compute'
              END
            END;;
  }
  dimension: trait {
    type: string
    sql: ${TABLE}."trait" ;;
  }
  dimension: rackPos {
    type: string
    sql: ${TABLE}."rack" ;;
  }
  dimension: AZ {
    type: string
    sql: ${TABLE}."Region" ;;
  }
  dimension: region {
    type: string
    sql: left(${AZ}, -1) ;;
  }
  dimension: serial {
    type: string
    sql: ${TABLE}."serialNo" ;;
  }


  dimension: setup {
    type: yesno
    sql: ${TABLE}."setup" ;;
  }
  dimension: ram {
    type: string
    sql: ${TABLE}."ram" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}."sku" ;;
  }
  dimension: rack {
    type: string
    sql: case
    when left(right((nodes."rack"), 3), 1) = '-' then
          left((nodes."rack"),-3)
          else
          left((nodes."rack"),-2)
          end ;;
  }
  measure: count {
    type: count
    drill_fields: []
  }
}

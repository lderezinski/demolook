
view: status_cnapi {

derived_table: {
  sql: SELECT * FROM (
      SELECT *, DENSE_RANK() OVER (ORDER BY z___min_rank) as z___pivot_row_rank, RANK() OVER (PARTITION BY z__pivot_col_rank ORDER BY z___min_rank) as z__pivot_col_ordering FROM (
      SELECT *, MIN(z___rank) OVER (PARTITION BY "cnapi.date_date") as z___min_rank FROM (
      SELECT *, RANK() OVER (ORDER BY "cnapi.date_date" DESC, z__pivot_col_rank) AS z___rank FROM (
      SELECT *, DENSE_RANK() OVER (ORDER BY CASE WHEN "cnapi.dc" IS NULL THEN 1 ELSE 0 END, "cnapi.dc" DESC) AS z__pivot_col_rank FROM (
      SELECT
        DATE(cnapi."DATE" ) AS "date",
        cnapi."DCENTER"  AS "dc",
        coalesce(COUNT(*),0) AS "CNcount"
      FROM smartdc.cnapi  AS cnapi
      full join smartdc.datacenters
         on smartdc.datacenters.name = cnapi."DCENTER"
      WHERE
        (((cnapi."DATE" ) >= ((SELECT (DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC')) + (-2 || ' month')::INTERVAL))) AND (cnapi."DATE" ) < ((SELECT ((DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'UTC')) + (-2 || ' month')::INTERVAL) + (3 || ' month')::INTERVAL)))))
      GROUP BY 1,2) ww
      ) bb WHERE z__pivot_col_rank <= 16384
      ) aa
      ) xx
      ) zz
       WHERE z___pivot_row_rank <= 5000 OR z__pivot_col_ordering = 1 ORDER BY z___pivot_row_rank
       ;;
}

measure: count {
  type: count
  drill_fields: [detail*]
}

dimension: cnapi_date_date {
  type: date
  sql: ${TABLE}."cnapi.date_date" ;;
}

dimension: cnapi_dc {
  type: string
  sql: ${TABLE}."cnapi.dc" ;;
}

dimension: cnapi_count {
  type: string
  sql: ${TABLE}."cnapi.count" ;;
}

dimension: z__pivot_col_rank {
  type: string
  sql: ${TABLE}.z__pivot_col_rank ;;
}

dimension: z___rank {
  type: string
  sql: ${TABLE}.z___rank ;;
}

dimension: z___min_rank {
  type: string
  sql: ${TABLE}.z___min_rank ;;
}

dimension: z___pivot_row_rank {
  type: string
  sql: ${TABLE}.z___pivot_row_rank ;;
}

dimension: z__pivot_col_ordering {
  type: string
  sql: ${TABLE}.z__pivot_col_ordering ;;
}

set: detail {
  fields: [
    cnapi_date_date,
    cnapi_dc,
    cnapi_count,
    z__pivot_col_rank,
    z___rank,
    z___min_rank,
    z___pivot_row_rank,
    z__pivot_col_ordering
  ]
}
}

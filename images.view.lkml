view: images {
  sql_table_name: smartdc.images ;;

  dimension: name {
    description: "The name of the image"
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql:${TABLE}.uuid || ${TABLE}.version || ${TABLE}.owner
  }
  dimension: dcgroup {
    description: "JPC or SPC"
    type: string
    sql: ${TABLE}.dcgroup ;;
  }
  dimension: os {
    description: "image manifest os"
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: owner {
    description: "image manifest owner, ufds UUID of the owner(s)"
    type: string
    sql: ${TABLE}.owner ;;
  }

  dimension: public {
    description: "image manifest public"
    type: yesno
    sql: ${TABLE}.public ;;
  }

  dimension: state {
    description: "image manifest stat"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: type {
    description: "image manifest type"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: uuid {
    description: "image manifest uuid (uuid of the image)"
    type: string
    sql: ${TABLE}.uuid ;;
  }

  dimension: v {
    description: "image manifest v"
    type: number
    sql: ${TABLE}.v ;;
  }

  dimension: version {
    description: "image manifest version"
    type: string
    sql: ${TABLE}.version ;;
  }

  measure: count {
    description: "Number of distinct images returned in query"
    type: count
    drill_fields: [name]
  }
}

view: d_supplier {
  sql_table_name: "DATA_MART"."D_SUPPLIER"
    ;;

  dimension: s_suppkey {
    type: number
    primary_key: yes
    sql: ${TABLE}."S_SUPPKEY" ;;
  }

  dimension: s_acctbal {
    type: number
    sql: ${TABLE}."S_ACCTBAL" ;;
  }

  dimension: s_address {
    type: string
    sql: ${TABLE}."S_ADDRESS" ;;
  }

  dimension: s_name {
    label: "Supplier Name"
    description: "Supplier name"
    type: string
    link: {
      label: "Link to the supplier"
      url: "https://www.google.com/search?q={{d_supplier.s_name._value}}"
      icon_url:"https://cdn-icons-png.flaticon.com/512/4866/4866608.png"}
    sql: ${TABLE}."S_NAME" ;;

  }

  dimension: s_nation {
    type: string
    sql: ${TABLE}."S_NATION" ;;
  }

  dimension: s_phone {
    type: string
    sql: ${TABLE}."S_PHONE" ;;
  }

  dimension: s_region {
    type: string
    sql: ${TABLE}."S_REGION" ;;
  }

  dimension: cohort_account_balance{
    type: tier
    tiers: [0, 1, 3001, 5001, 7001]
    style: integer
    sql: ${s_acctbal} ;;
  }

set: supplier_detail {
  fields: [s_region,
           cohort_account_balance
            ]
}

  measure: count {
    type: count
    drill_fields: [supplier_detail*]
  }

}

view: d_customer {
  sql_table_name: "DATA_MART"."D_CUSTOMER"
    ;;

  dimension: c_custkey {
    type: number
    primary_key: yes
    sql: ${TABLE}."C_CUSTKEY" ;;
  }

  dimension: c_address {
    type: string
    sql: ${TABLE}."C_ADDRESS" ;;
  }



  dimension: c_mktsegment {
    type: number
    sql: ${TABLE}."C_MKTSEGMENT" ;;
  }


  dimension: c_name {
    type: string
    sql: ${TABLE}."C_NAME" ;;
  }

  dimension: c_nation {
    type: string
    sql: upper(${TABLE}."C_NATION") ;;
  }

  dimension: c_phone {
    type: string
    sql: '+' || ${TABLE}."C_PHONE" ;; # concat test
  }

  dimension: c_region {
    type: string
    sql: ${TABLE}."C_REGION" ;;
    #html: <a href="/dashboards/266">{{ value }}</a> ;;
    link: {
      label: "Summary Dashboard Target by Artsiom Ryzhkovich"
      url: "dashboards/266?Customer+Nation=&Year+Quarter+Month+Test=Month&Customer+Region= {{ value | url_encode }}"
    }
  }

  measure: count {
    type: count
    drill_fields: [c_region, c_address, c_name]
  }

  #Liquid Hyperlink
  dimension: customer_name {
    type: string
    sql: ${c_name} ;;
    html: <a href="https://www.google.com/search?q={{value}}">{{ value }}</a> ;;
  }
}

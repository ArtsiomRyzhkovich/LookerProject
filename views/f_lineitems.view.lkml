view: f_lineitems {
  sql_table_name: "DATA_MART"."F_LINEITEMS"
    ;;

  dimension: l_linenumber {
    type: number
    primary_key:  yes
    sql: ${TABLE}."L_LINENUMBER" ;;
  }


  dimension: l_orderkey {
    type: number
    sql: ${TABLE}."L_ORDERKEY" ;;
  }


  dimension: l_orderdatekey {
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }

  dimension: l_availqty {
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }

  dimension: l_clerk {
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }

  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }

  dimension: l_custkey {
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }

  dimension: l_discount {
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }

  dimension: l_extendedprice {
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }


  dimension: l_orderpriority {
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }

  dimension: l_orderstatus {
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }

  dimension: l_partkey {
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }

  dimension: l_quantity {
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }

  dimension: l_receiptdatekey {
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }

  dimension: l_returnflag {
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }

  dimension: l_shipdatekey {
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }

  dimension: l_shipinstruct {
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }

  dimension: l_shipmode {
    type: string
    sql: ${TABLE}."L_SHIPMODE" ;;
  }

  dimension: l_shippriority {
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }

  dimension: l_suppkey {
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }

  dimension: l_supplycost {
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }

  dimension: l_tax {
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }

  dimension: l_totalprice {
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

#custom measures
  measure: total_sales_price{
    type: sum
    sql: ${l_totalprice} ;;
    value_format_name: "usd"
  }

  measure: avg_sales_price{
    type: average
    sql: ${l_totalprice} ;;
    value_format_name: "usd"
  }

  measure: cumulative_total_sales {
    type: sum
    sql: running_total(${l_totalprice}) ;;
    value_format_name: "usd"
  }

  measure: total_sales_shiped_by_air{
    type: sum
    filters: [l_shipmode: "AIR, REG AIR"]
    sql: ${l_totalprice} ;;
  }

  measure: total_russia_sales{
    type: sum
    filters: [d_customer.c_nation: "RUSSIA"]
    sql: ${l_totalprice} ;;

    value_format_name: "usd"
  }

  measure: total_gross_revenue {
    description: "F-Fulfilled"
    type: sum
    filters: [l_orderstatus: "F"] #Fulfilled???
    sql: ${l_totalprice} ;;
  }

  measure: total_cost {
    type:  sum
    sql: ${l_supplycost} ;;
  }

  measure: total_gross_margin_amount {
    type: number
    sql: ${total_gross_revenue} - ${total_cost};;
    drill_fields: [l_shipmode, d_supplier.supplier_detail*,  total_gross_margin_amount]
  }


  measure: gross_margin_percentage {
    type: number
    value_format_name: percent_2
    sql: ${total_gross_margin_amount} / NULLIF(${total_gross_revenue}, 0);;
  }


  measure: number_of_items_returned {
    type:sum
    filters: [l_returnflag: "R"]
    sql: ${l_quantity} ;;
  }

  measure: total_number_of_items_sold {
    type:sum
    sql: ${l_quantity} ;;
  }

  measure: item_return_rate {
    type: number
    value_format_name: percent_2
    sql: ${number_of_items_returned} / NULLIF(${total_number_of_items_sold}, 0)  ;;
  }

  measure: average_spend_per_customer {
    type: number

    sql: ${total_sales_price} / NULLIF(${d_customer.count}, 0)  ;;
  }

  # • Total Number of orders for 1 Jan 1995
  measure: total_number_of_order {
    type: count_distinct
    sql: ${l_orderkey} ;;
  }

  measure:  number_of_sales{
    type: count_distinct
    sql: ${l_totalprice} ;;
  }
#Liquid test
  dimension: priority_colors  {
    type: number
    sql: ${l_shippriority} ;;
    html: <b><right><font size="5" color="#2a9d8f" >{{value}}</font></right></b> ;;
  }

}

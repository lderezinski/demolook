- dashboard: jpc_account_lookup
  title: Account Lookup
  layout: newspaper
  elements:
  - title: Account Comparitor
    name: Account Comparitor
    model: joyent_public_cloud
    explore: jpcdaily_spend
    type: looker_bar
    fields:
    - jpc_account_facts.account_comparitor
    - jpc_account_facts.overall_spend_comparitor
    filters:
      jpc_account_facts.account_select:
    sorts:
    - jpc_account_facts.overall_spend_comparitor desc
    limit: 500
    column_limit: 50
    query_timezone: UTC
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors:
    - 'palette: Mixed Pastels'
    series_colors: {}
    listen:
      Account Number: jpc_account_facts.account_select
    row: 0
    col: 7
    width: 17
    height: 8
  - title: Untitled
    name: Untitled
    model: joyent_public_cloud
    explore: jpcdaily_spend
    type: looker_single_record
    fields:
    - jpcdaily_spend.accountnumber
    - zuora_customers.category
    - jpc_account_facts.account_health
    - jpc_account_facts.account_health_score
    - jpc_account_facts.total_spend
    - jpc_account_facts.total_orders
    filters:
      jpcdaily_spend.accountnumber:
    sorts:
    - jpcdaily_spend.accountnumber
    limit: 500
    column_limit: 50
    show_view_names: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Account Number: jpcdaily_spend.accountnumber
    row: 0
    col: 0
    width: 7
    height: 8
  filters:
  - name: Account Number
    title: Account Number
    type: field_filter
    default_value: '00247dbe-e353-c271-de2c-c53d254d8d3c'
    model: joyent_public_cloud
    explore: jpcdaily_spend
    field: jpcdaily_spend.accountnumber
    listens_to_filters: []
    allow_multiple_values: true
    required: false

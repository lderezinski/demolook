- dashboard: jpc_accounts
  title: Account Management
  layout: newspaper
  elements:
  - title: Accounts by Account Health
    name: Accounts by Account Health
    model: operations
    explore: dailyspend
    type: looker_column
    fields:
    - account_facts.account_health
    - zcustomers.count
    sorts:
    - account_facts.account_health desc
    limit: 500
    column_limit: 50
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    row: 0
    col: 0
    width: 8
    height: 6
  - name: Accounts by Spend Tier
    title: Accounts by Spend Tier
    model: operations
    explore: dailyspend
    type: looker_column
    fields:
    - account_facts.total_spend_tier
    - zcustomers.count
    fill_fields:
    - account_facts.total_spend_tier
    sorts:
    - account_facts.total_spend_tier
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    row: 0
    col: 8
    width: 10
    height: 6
  - name: Customers by Created Date
    title: Customers by Created Date
    model: operations
    explore: dailyspend
    type: looker_line
    fields:
    - zcustomers.count
    - zcustomers.createddate_week
    filters:
      zcustomers.createddate_date: this year
    sorts:
    - zcustomers.createddate_week desc
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: monotone
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors:
    - 'palette: Mixed Pastels'
    series_colors: {}
    row: 6
    col: 0
    width: 18
    height: 8
  - name: Top 20 Decreased Customers
    title: Top 20 Decreased Customers
    model: operations
    explore: dailyspend
    type: table
    fields:
    - dailyspend.accountnumber
    - dailyspend.difference
    filters:
      dailyspend.day_date: 2017/10/10 to 2017/10/16
    sorts:
    - dailyspend.difference
    limit: 5000
    column_limit: 50
    query_timezone: UTC
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    row: 6
    col: 18
    width: 6
    height: 8
  - name: Top 10 Spending Accounts
    title: Top 10 Spending Accounts
    model: operations
    explore: dailyspend
    type: table
    fields:
    - dailyspend.accountnumber
    - dailyspend.sum_spend
    filters:
      dailyspend.day_date: 2017/10/12
    sorts:
    - dailyspend.sum_spend desc
    limit: 500
    column_limit: 50
    query_timezone: UTC
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: true
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    row: 0
    col: 18
    width: 6
    height: 6
  - title: Spend Over Time
    name: Spend Over Time
    model: operations
    explore: dailyspend
    type: looker_line
    fields:
    - dailyspend.day_week
    - dailyspend.sum_spend
    fill_fields:
    - dailyspend.day_week
    sorts:
    - dailyspend.day_week desc
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: monotone
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    listen:
      Date: dailyspend.day_date
    row: 14
    col: 0
    width: 12
    height: 8
  - title: Retention Curve
    name: Retention Curve
    model: operations
    explore: dailyspend
    type: looker_line
    fields:
    - dailyspend.months_since_signup
    - zcustomers.createddate_month
    - dailyspend.sum_spend
    pivots:
    - zcustomers.createddate_month
    fill_fields:
    - zcustomers.createddate_month
    filters:
      zcustomers.createddate_month: this year
      dailyspend.day_date: this year
    sorts:
    - zcustomers.createddate_month 0
    - dailyspend.months_since_signup
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
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_series:
    - 2017-04
    - 2017-05
    - 2017-06
    - 2017-07
    - 2017-08
    - 2017-09
    - 2017-10
    - 2017-11
    - 2017-12
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    row: 14
    col: 12
    width: 12
    height: 8
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: this year
    model: operations
    explore: dailyspend
    field: dailyspend.day_date
    listens_to_filters: []
    allow_multiple_values: true
    required: false

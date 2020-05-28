- dashboard: spc_manta_monthly_samsung_account
  title: SPC Manta Monthly Samsung Account
  layout: newspaper
  elements:
  - title: Date
    name: Date
    model: joyent_public_cloud
    explore: spcmantastorage
    type: single_value
    fields: [mantagoal.goalsum, spcmantastorage.date_date, spcmantastorage.region,
      spcmantastorage.data_p]
    filters:
      ufds.grouped_name: Samsung Cloud
      spcmantastorage.date_date: 2 months
    sorts: [spcmantastorage.date_date desc]
    limit: 500
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [spcmantastorage.data_p, mantagoal.goalsum, spcmantastorage.region,
      scloud_usage, scloud_usage_pib, delivered_storage_pib]
    listen: {}
    row: 0
    col: 0
    width: 8
    height: 8
  - title: SCLOUD Manta Metering
    name: SCLOUD Manta Metering
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [mantagoal.goalsum, spcmantastorage.date_date, spcmantastorage.region,
      spcmantastorage.data_p]
    filters:
      spcmantastorage.date_date: 2 months
    sorts: [spcmantastorage.date_date desc]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: scloud_usage, label: SCLOUD Usage (%), expression: "${spcmantastorage.data_p}/${mantagoal.goalsum}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}, {table_calculation: scloud_usage_pib, label: SCLOUD Usage
          (PiB), expression: "${spcmantastorage.data_p}", value_format: !!null '',
        value_format_name: decimal_2, _kind_hint: measure, _type_hint: number}, {
        table_calculation: delivered_storage_pib, label: Delivered Storage (PiB),
        expression: "${mantagoal.goalsum}", value_format: !!null '', value_format_name: decimal_2,
        _kind_hint: measure, _type_hint: number}]
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [spcmantastorage.data_p, mantagoal.goalsum, spcmantastorage.date_date]
    listen:
      SCLOUD: ufds.grouped_name
    row: 0
    col: 8
    width: 16
    height: 4
  - title: SCLOUD Manta Metering by account
    name: SCLOUD Manta Metering by account
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.date_date, spcmantastorage.region, spcmantastorage.data_p,
      ufds.login]
    pivots: [spcmantastorage.region]
    filters:
      spcmantastorage.date_date: 2 months
      ufds.login: "%.prd%,%.stg%,%.dev%"
    sorts: [spcmantastorage.date_date desc, spcmantastorage.region]
    limit: 500
    total: true
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [manta_zfs.date_date, spcmantastorage.date_date]
    show_null_points: true
    interpolation: linear
    listen:
      SCLOUD: ufds.grouped_name
    row: 4
    col: 8
    width: 16
    height: 4
  - name: Manta Metering Historical Data
    type: text
    title_text: Manta Metering Historical Data
    row: 22
    col: 0
    width: 24
    height: 2
  - title: All Accounts (PiB)
    name: All Accounts (PiB)
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.date_date, spcmantastorage.region, spcmantastorage.data_p]
    pivots: [spcmantastorage.region]
    filters:
      spcmantastorage.date_date: 7 months
    sorts: [spcmantastorage.date_date desc, spcmantastorage.region]
    limit: 500
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) OR\n(trunc_days(${spcmantastorage.date_date}) = trunc_days(now()) AND \n\
      (trunc_months(${spcmantastorage.date_date}) = trunc_months(now()) ))"
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
      spcmantastorage.data_p: Data
      spcmantastorage.date_date: Date
    series_cell_visualizations:
      spcmantastorage.data_p:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields:
    listen:
      All: ufds.grouped_name
    row: 24
    col: 0
    width: 24
    height: 4
  - name: Manta Metering Last Month
    type: text
    title_text: Manta Metering Last Month
    row: 8
    col: 0
    width: 24
    height: 2
  - title: All Accounts
    name: All Accounts
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [mantagoal.goalsum, spcmantastorage.date_date, spcmantastorage.region,
      spcmantastorage.data_p]
    filters:
      spcmantastorage.date_date: 2 months
    sorts: [spcmantastorage.date_date desc]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: scloud_usage, label: SCLOUD Usage (%), expression: "${spcmantastorage.data_p}/${mantagoal.goalsum}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}, {table_calculation: scloud_usage_pib, label: SCLOUD Usage
          (PiB), expression: "${spcmantastorage.data_p}", value_format: !!null '',
        value_format_name: decimal_2, _kind_hint: measure, _type_hint: number}, {
        table_calculation: delivered_storage_pib, label: Delivered Storage (PiB),
        expression: "${mantagoal.goalsum}", value_format: !!null '', value_format_name: decimal_2,
        _kind_hint: measure, _type_hint: number}]
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [spcmantastorage.data_p, mantagoal.goalsum, spcmantastorage.date_date]
    listen:
      All: ufds.grouped_name
    row: 10
    col: 0
    width: 24
    height: 4
  - title: SCLOUD
    name: SCLOUD
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [mantagoal.goalsum, spcmantastorage.date_date, spcmantastorage.region,
      spcmantastorage.data_p]
    filters:
      spcmantastorage.date_date: 2 months
    sorts: [spcmantastorage.date_date desc]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: scloud_usage, label: SCLOUD Usage (%), expression: "${spcmantastorage.data_p}/${mantagoal.goalsum}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}, {table_calculation: scloud_usage_pib, label: SCLOUD Usage
          (PiB), expression: "${spcmantastorage.data_p}", value_format: !!null '',
        value_format_name: decimal_2, _kind_hint: measure, _type_hint: number}, {
        table_calculation: delivered_storage_pib, label: Delivered Storage (PiB),
        expression: "${mantagoal.goalsum}", value_format: !!null '', value_format_name: decimal_2,
        _kind_hint: measure, _type_hint: number}]
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [spcmantastorage.data_p, mantagoal.goalsum, spcmantastorage.date_date]
    listen:
      SCLOUD: ufds.grouped_name
    row: 14
    col: 0
    width: 24
    height: 4
  - title: SPASS
    name: SPASS
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [mantagoal.goalsum, spcmantastorage.date_date, spcmantastorage.region,
      spcmantastorage.data_p]
    filters:
      spcmantastorage.date_date: 2 months
    sorts: [spcmantastorage.date_date desc]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: scloud_usage, label: SCLOUD Usage (%), expression: "${spcmantastorage.data_p}/${mantagoal.goalsum}",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}, {table_calculation: scloud_usage_pib, label: SCLOUD Usage
          (PiB), expression: "${spcmantastorage.data_p}", value_format: !!null '',
        value_format_name: decimal_2, _kind_hint: measure, _type_hint: number}, {
        table_calculation: delivered_storage_pib, label: Delivered Storage (PiB),
        expression: "${mantagoal.goalsum}", value_format: !!null '', value_format_name: decimal_2,
        _kind_hint: measure, _type_hint: number}]
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields: [spcmantastorage.data_p, mantagoal.goalsum, spcmantastorage.date_date]
    listen:
      SPASS: ufds.grouped_name
    row: 18
    col: 0
    width: 24
    height: 4
  - title: SCLOUD
    name: SCLOUD (2)
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.date_date, spcmantastorage.region, spcmantastorage.data_p]
    pivots: [spcmantastorage.region]
    filters:
      spcmantastorage.date_date: 7 months
    sorts: [spcmantastorage.date_date desc, spcmantastorage.region]
    limit: 500
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) OR\n(trunc_days(${spcmantastorage.date_date}) = trunc_days(now()) AND \n\
      (trunc_months(${spcmantastorage.date_date}) = trunc_months(now()) ))"
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
      spcmantastorage.data_p: Data
      spcmantastorage.date_date: Date
    series_cell_visualizations:
      spcmantastorage.data_p:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields:
    listen:
      SCLOUD: ufds.grouped_name
    row: 28
    col: 0
    width: 24
    height: 4
  - title: SPASS Manta Metering
    name: SPASS Manta Metering
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.date_date, spcmantastorage.region, spcmantastorage.data_p]
    pivots: [spcmantastorage.region]
    filters:
      spcmantastorage.date_date: 7 months
    sorts: [spcmantastorage.date_date desc, spcmantastorage.region]
    limit: 500
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) OR\n(trunc_days(${spcmantastorage.date_date}) = trunc_days(now()) AND \n\
      (trunc_months(${spcmantastorage.date_date}) = trunc_months(now()) ))"
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
      spcmantastorage.date_date: Date
      spcmantastorage.data_p: Data
    series_cell_visualizations:
      spcmantastorage.data_p:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    hidden_fields:
    listen:
      SPASS: ufds.grouped_name
    row: 32
    col: 0
    width: 24
    height: 5
  filters:
  - name: SCLOUD
    title: SCLOUD
    type: field_filter
    default_value: Samsung Cloud
    allow_multiple_values: true
    required: false
    model: joyent_public_cloud
    explore: jcbw
    listens_to_filters: []
    field: ufds.grouped_name
  - name: SPASS
    title: SPASS
    type: field_filter
    default_value: Samsung Pass
    allow_multiple_values: true
    required: false
    model: joyent_public_cloud
    explore: jcbw
    listens_to_filters: []
    field: ufds.grouped_name
  - name: All
    title: All
    type: field_filter
    default_value: Samsung Pass,Samsung Cloud
    allow_multiple_values: true
    required: false
    model: joyent_public_cloud
    explore: jcbw
    listens_to_filters: []
    field: ufds.grouped_name

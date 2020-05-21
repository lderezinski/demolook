- dashboard: pi_team_srem71
  title: PI Team SREM-71
  layout: newspaper
  elements:
  - title: SCLOUD Manta Metering
    name: SCLOUD Manta Metering
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [mantagoal.goalsum, spcmantastorage.date_date, spcmantastorage.region,
      spcmantastorage.data_p]
    filters:
      ufds.grouped_name: Samsung Cloud
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
    listen: {}
    row: 0
    col: 6
    width: 9
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
      ufds.grouped_name: Samsung Cloud
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
    listen: {}
    row: 0
    col: 15
    width: 9
    height: 4
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
    width: 6
    height: 4
  - name: Total Usage at the end of months based on accounts
    type: text
    title_text: Total Usage at the end of months based on accounts
    row: 4
    col: 0
    width: 24
    height: 2
  - title: Manta Metering all accounts
    name: Manta Metering all accounts
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
    listen: {}
    row: 6
    col: 0
    width: 10
    height: 4
  - title: SCLOUD Manta Metering
    name: SCLOUD Manta Metering (2)
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [mantagoal.goalsum, spcmantastorage.date_date, spcmantastorage.region,
      spcmantastorage.data_p]
    filters:
      spcmantastorage.date_date: 2 months
      ufds.grouped_name: Samsung Cloud
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
    listen: {}
    row: 10
    col: 0
    width: 10
    height: 4
  - title: SPASS Manta Metering
    name: SPASS Manta Metering
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [mantagoal.goalsum, spcmantastorage.date_date, spcmantastorage.region,
      spcmantastorage.data_p]
    filters:
      spcmantastorage.date_date: 2 months
      ufds.grouped_name: Samsung Pass
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
    listen: {}
    row: 14
    col: 0
    width: 10
    height: 4
  - title: Other accounts Manta Metering
    name: Other accounts Manta Metering
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [mantagoal.goalsum, spcmantastorage.date_date, spcmantastorage.region,
      spcmantastorage.data_p]
    filters:
      spcmantastorage.date_date: 2 months
      ufds.grouped_name: "-Samsung Pass,-Samsung Cloud"
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
    listen: {}
    row: 18
    col: 0
    width: 10
    height: 4
  - title: Manta Metering all accounts
    name: Manta Metering all accounts (2)
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.date_date, spcmantastorage.region, spcmantastorage.data_p]
    pivots: [spcmantastorage.region]
    filters:
      spcmantastorage.date_date: 7 months
    sorts: [spcmantastorage.date_date desc, spcmantastorage.region]
    limit: 500
    total: true
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
    listen: {}
    row: 24
    col: 0
    width: 10
    height: 4
  - name: Historical data
    type: text
    title_text: Historical data
    row: 22
    col: 0
    width: 24
    height: 2
  - title: SCLOUD Manta Metering
    name: SCLOUD Manta Metering (3)
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.date_date, spcmantastorage.region, spcmantastorage.data_p]
    pivots: [spcmantastorage.region]
    filters:
      spcmantastorage.date_date: 7 months
      ufds.grouped_name: Samsung Cloud
    sorts: [spcmantastorage.date_date desc, spcmantastorage.region]
    limit: 500
    total: true
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
    listen: {}
    row: 28
    col: 0
    width: 10
    height: 4
  - title: SPASS Manta Metering
    name: SPASS Manta Metering (2)
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.date_date, spcmantastorage.region, spcmantastorage.data_p]
    pivots: [spcmantastorage.region]
    filters:
      spcmantastorage.date_date: 7 months
      ufds.grouped_name: Samsung Pass
    sorts: [spcmantastorage.date_date desc, spcmantastorage.region]
    limit: 500
    total: true
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
    listen: {}
    row: 32
    col: 0
    width: 10
    height: 4
  - title: Other Accounts Manta Metering
    name: Other Accounts Manta Metering
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.date_date, spcmantastorage.region, spcmantastorage.data_p]
    pivots: [spcmantastorage.region]
    filters:
      spcmantastorage.date_date: 7 months
      ufds.grouped_name: "-Samsung Pass,-Samsung Cloud"
    sorts: [spcmantastorage.date_date desc, spcmantastorage.region]
    limit: 500
    total: true
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
    listen: {}
    row: 36
    col: 0
    width: 10
    height: 4
  - title: Manta Metering us-east
    name: Manta Metering us-east
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_pie
    fields: [spcmantastorage.data_p, ufds.grouped_name]
    filters:
      spcmantastorage.date_date: 2 months
      spcmantastorage.data_p: ">0.0001"
      spcmantastorage.region: us-east
    sorts: [spcmantastorage.data_p desc]
    limit: 500
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    value_labels: legend
    label_type: labPer
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
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
    listen: {}
    row: 14
    col: 17
    width: 7
    height: 8
  - title: Manta Metering eu-central
    name: Manta Metering eu-central
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_pie
    fields: [spcmantastorage.data_p, ufds.grouped_name]
    filters:
      spcmantastorage.date_date: 2 months
      spcmantastorage.data_p: ">0.0001"
      spcmantastorage.region: eu-central
    sorts: [spcmantastorage.data_p desc]
    limit: 500
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    value_labels: legend
    label_type: labPer
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
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
    listen: {}
    row: 14
    col: 10
    width: 7
    height: 8
  - title: Manta Metering ap-northeast
    name: Manta Metering ap-northeast
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_pie
    fields: [spcmantastorage.data_p, ufds.grouped_name]
    filters:
      spcmantastorage.date_date: 2 months
      spcmantastorage.data_p: ">0.0001"
      spcmantastorage.region: ap-northeast
    sorts: [spcmantastorage.data_p desc]
    limit: 500
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    value_labels: legend
    label_type: labPer
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
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
    listen: {}
    row: 6
    col: 10
    width: 7
    height: 8
  - title: Manta Metering ap-southeast
    name: Manta Metering ap-southeast
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_pie
    fields: [spcmantastorage.data_p, ufds.grouped_name]
    filters:
      spcmantastorage.date_date: 2 months
      spcmantastorage.data_p: ">0.0001"
      spcmantastorage.region: ap-southeast
    sorts: [spcmantastorage.data_p desc]
    limit: 500
    filter_expression: "(extract_days(add_days(1,${spcmantastorage.date_date})) =\
      \ 1) "
    value_labels: legend
    label_type: labPer
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
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
    listen: {}
    row: 6
    col: 17
    width: 7
    height: 8
  - title: Manta Metering all accounts
    name: Manta Metering all accounts (3)
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_line
    fields: [spcmantastorage.date_date, spcmantastorage.region, spcmantastorage.data_p]
    pivots: [spcmantastorage.region]
    filters:
      spcmantastorage.date_date: 7 months
    sorts: [spcmantastorage.date_date desc, spcmantastorage.region]
    limit: 5000
    total: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: Total PiB, orientation: left, series: [{axisId: spcmantastorage.data_p,
            id: ap-northeast - spcmantastorage.data_p, name: ap-northeast}, {axisId: spcmantastorage.data_p,
            id: ap-southeast - spcmantastorage.data_p, name: ap-southeast}, {axisId: spcmantastorage.data_p,
            id: eu-central - spcmantastorage.data_p, name: eu-central}, {axisId: spcmantastorage.data_p,
            id: us-east - spcmantastorage.data_p, name: us-east}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_types: {}
    series_labels:
      scloud_usage_pib: Total Usage (PiB)
      scloud_usage: Total Usage (%)
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 24
    col: 10
    width: 14
    height: 16

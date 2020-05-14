- dashboard: pi_team_serm71
  title: PI Team SERM-71
  layout: newspaper
  elements:
  - title: SCLOUD SPC Object Storage Usage (ZFS)
    name: SCLOUD SPC Object Storage Usage (ZFS)
    model: joyent_public_cloud
    explore: manta_zfs
    type: looker_grid
    fields: [manta_zfs.date_date, manta_zfs.region, manta_zfs.total_used_pib, mantagoal.goalsum]
    filters:
      manta_zfs.date_date: 2 months
    sorts: [manta_zfs.date_date desc, manta_zfs.region]
    limit: 500
    total: true
    dynamic_fields: [{table_calculation: usage, label: Usage %, expression: "${manta_zfs.total_used_pib}/${mantagoal.goalsum}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}, {table_calculation: scloud_usage_pib, label: SCLOUD Usage
          PiB, expression: "${manta_zfs.total_used_pib}", value_format: !!null '',
        value_format_name: decimal_2, _kind_hint: measure, _type_hint: number}, {
        table_calculation: delivered_storage_pib, label: Delivered Storage PiB, expression: "${mantagoal.goalsum}",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    filter_expression: "(extract_days(add_days(1,${manta_zfs.date_date})) = 1) "
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
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    hidden_fields: [mantagoal.goalsum, manta_zfs.total_used_pib]
    listen: {}
    row: 0
    col: 12
    width: 12
    height: 4
  - title: SPC Manta Metering
    name: SPC Manta Metering
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
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    hidden_fields: [spcmantastorage.data_p, mantagoal.goalsum]
    row: 0
    col: 0
    width: 12
    height: 4
  - title: SPC Manta Metering by account
    name: SPC Manta Metering by account
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
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    show_null_points: true
    interpolation: linear
    listen: {}
    row: 4
    col: 0
    width: 12
    height: 4
  - title: Manta Goal
    name: Manta Goal
    model: joyent_public_cloud
    explore: manta_zfs
    type: looker_grid
    fields: [mantagoal.goal, mantagoal.region]
    filters:
      manta_zfs.date_date: 2 months
    limit: 500
    total: true
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
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    hidden_fields: []
    listen: {}
    row: 4
    col: 12
    width: 12
    height: 4

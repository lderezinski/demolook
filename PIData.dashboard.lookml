- dashboard: dash265
  title: DASH-265
  layout: newspaper
  elements:
  - title: Accounts
    name: Accounts
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [ufds.uuid, ufds.login, ufds.email, ufds.givenname, ufds.sn, ufds.cn,
      ufds.company, ufds.grouped_name, ufds.display_name, spcmantastorage.data_p]
    filters:
      spcmantastorage.date_date: 30 days
      ufds.grouped_name: Samsung Pass,Samsung Cloud
    sorts: [spcmantastorage.data_p desc]
    limit: 500
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
    hidden_fields: [spcmantastorage.data_p]
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 7
  - title: deliveredPiB
    name: deliveredPiB
    model: joyent_public_cloud
    explore: spcmantastorage
    type: table
    fields: [mantagoal.region, mantagoal.date_date, mantagoal.goal]
    filters:
      mantagoal.date_date: yesterday
    sorts: [mantagoal.date_date desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_labels:
      mantagoal.goal: PiB
    defaults_version: 1
    listen: {}
    row: 7
    col: 0
    width: 8
    height: 4
  - title: totalUsedPiB
    name: totalUsedPiB
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.region, spcmantastorage.date_date, spcmantastorage.data_p,
      spcmantastorage.sumobjects]
    filters:
      spcmantastorage.date_date: yesterday
      ufds.grouped_name: Samsung Pass,Samsung Cloud
    sorts: [spcmantastorage.date_date desc]
    limit: 500
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
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      spcmantastorage.objectcount: Count
    series_cell_visualizations:
      spcmantastorage.data_p:
        is_active: true
    hidden_fields: []
    defaults_version: 1
    listen: {}
    row: 7
    col: 8
    width: 16
    height: 4
  - title: usedAccountPiB
    name: usedAccountPiB
    model: joyent_public_cloud
    explore: spcmantastorage
    type: looker_grid
    fields: [spcmantastorage.region, spcmantastorage.date_date, spcmantastorage.bytes,
      spcmantastorage.objectcount, ufds.uuid]
    filters:
      spcmantastorage.date_date: yesterday
      ufds.grouped_name: Samsung Pass,Samsung Cloud
    sorts: [spcmantastorage.date_date desc]
    limit: 500
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
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      spcmantastorage.objectcount: Count
    hidden_fields: []
    defaults_version: 1
    listen: {}
    row: 11
    col: 0
    width: 24
    height: 14

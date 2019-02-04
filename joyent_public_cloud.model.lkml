connection: "joyent"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "//zendesk/users.view.lkml"
include: "//zendesk/tickets.view.lkml"


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

explore: ram_values {
  hidden: yes
}
explore: status_cnapi {

}
explore: customer_facts {
}
explore: manta_zfs {
  description: "ZFS capacity"
  group_label: "Joyent Cloud"
  label: "manta capacity"
  join: mantagoal {
    type: full_outer
    sql_on: ${mantagoal.date_date} = ${manta_zfs.date_date} and ${mantagoal.region} = ${manta_zfs.region} ;;
    relationship: many_to_one
  }
}
explore: storageforecast {
  description: "SDC Storage forecasting"
  group_label: "Joyent Cloud"
  label: "Storage Forecast"
  #join: step_storageforecast {
  #  from: storageforecast
  #  type: left_outer
  #  sql_on: ${storageforecast.fcst} = ${step_storageforecast.fcst} and
  #          ${storageforecast.region} = ${step_storageforecast.region} and
  #          ${storageforecast.half_year} =  ${step_storageforecast.delivery_month}

#    ;;
 #   relationship: many_to_one

  #}
  #join: storage_forecast_build {
  #  type: inner
  #  sql_on: ${storageforecast.delivery_raw} = ${storage_forecast_build.build_start_raw}
  #  and ${step_storageforecast.region} = ${storage_forecast_build.region};;
  #  relationship: many_to_one
  #}
  join: manta_zfs {
    type: full_outer
    sql_on: ${manta_zfs.region} = ${storageforecast.region} and ${manta_zfs.date_date} = ${storageforecast.delivery_date};;
    relationship: one_to_many
  }
  join: mantagoal {
    type: full_outer
    sql_on: ${mantagoal.date_date} = ${storageforecast.delivery_date} and ${mantagoal.region} = ${storageforecast.region} ;;
    relationship: many_to_one
  }
}

explore: storagebuild {
  description: "SDC Storage Build"
  group_label: "Joyent Cloud"
  label: "Storage Build"
}
explore: nodes {
  description: "cnapi summary"
  group_label: "Joyent Cloud"
  label: "Nodes"

}
explore: inventory {
  description: "Node Inventory"
  group_label: "Joyent Cloud"
  label: "Inventory"
  join: server_sku {
    from: inventory
    sql_on: ${inventory.sku} = ${server_sku.sku} ;;
    relationship: many_to_one
  }
}


explore: bpr {
  description: "Billing Preview"
  group_label: "Joyent Cloud"
  label: "bpr"
  join: zuora_customers {
    view_label: "Customers"
    sql_on: ${zuora_customers.accountnumber} = ${bpr.account_number} ;;
    type: left_outer
    relationship: many_to_one

  }
  join: papi {
    view_label: "Packages"
    sql_on: ${bpr.uom} = ${papi.billing_tag} ;;
    type:  full_outer
    relationship: many_to_one
  }
}
explore: ufds {
    description: "UFDS"
    group_label: "Joyent Cloud"
    label: "ufds"

  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on: ${ufdsgroupname.uuid} = ${ufds.uuid} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: zuora_customers {
    view_label: "Customers"
    sql_on: ${zuora_customers.accountnumber} = ${ufds.uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
 join: users {
   sql_on: ${users.email} = ${ufds.email} ;;
   type: left_outer
   relationship: one_to_one
 }
 join: tickets  {
   sql_on: ${users.id} =  ${tickets.requester_id} ;;
   type: left_outer
   relationship: one_to_many
 }
}

explore: mantastorage {
  description: "Manta Storage"
  group_label: "Joyent Cloud"
  label: "Manta Storage"

  join: ufds {
    view_label: "Customers"
    sql_on: ${mantastorage.owner} = ${ufds.uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on: ${ufdsgroupname.uuid} = ${mantastorage.owner} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: zuora_customers {
    view_label: "Customers"
    sql_on: ${zuora_customers.accountnumber} = ${mantastorage.owner} ;;
    type: left_outer
    relationship: many_to_one
  }
}



explore: zinvoiceitems {
  description: "Invoice Items"
  group_label: "Joyent Cloud"
  label: "Invoice Items"
#   always_filter: {
#     filters: {
#       field: zuora_customers.isFree
#       value: "No"
#     }
#   }
  join: ufds {
    view_label: "Customers"
    sql_on: ${zinvoiceitems.account_number} = ${ufds.uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on: ${ufdsgroupname.uuid} = ${zinvoiceitems.account_number} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: zuora_customers {
    view_label: "Customers"
    sql_on: ${zuora_customers.accountnumber} = ${zinvoiceitems.account_number} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: users {
    view_label: "Zendesk Users"
    sql_on: ${users.email} = ${ufds.email} ;;
    type: left_outer
    relationship: one_to_one
  }
  join: tickets  {
    view_label: "Zendesk Tickets"
    sql_on: ${users.id} =  ${tickets.requester_id} ;;
    type: left_outer
    relationship: one_to_many
  }

}

explore: datacenters {
  description: "DC"
  group_label: "Joyent Cloud"
  label: "dc"
}

explore: cnapi {
  description: "CNApi"
  group_label: "Joyent Cloud"
  label: "cnapi"
  join: datacenters {
    view_label: "DC"
    sql_on: ${datacenters.name} = ${cnapi.dc} ;;
    type: left_outer
    relationship: many_to_one
  }

  join: papi {
    view_label: "Packages"
    sql_on: ${cnapi.setup} = ${papi.active} ;;
    type:  full_outer
    relationship: many_to_one
  }

}
explore:vmapi {
  description: "VMApi"
  group_label: "Joyent Cloud"
  label: "vmapi"
  join: ufds {
    view_label: "ufds"
    sql_on: ${ufds.uuid}=${vmapi.owner_uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on:  ${vmapi.owner_uuid} = ${ufdsgroupname.uuid};;
    type: left_outer
    relationship: one_to_one
  }
  join: datacenters {
    view_label: "DC"
    sql_on: ${datacenters.name} = ${vmapi.datacenter} ;;
    type: full_outer
    relationship: many_to_one
  }
  join: papi {
    view_label: "Packages"
    sql_on: ${vmapi.billing_id} = ${papi.uuid} ;;
    type:  left_outer
    relationship: many_to_one
  }

  join: images {
    view_label: "images"
    sql_on: ${images.uuid} = ${vmapi.image_uuid} ;;
    type: left_outer
    relationship: many_to_one
  }
  join: cnapi {
    view_label: "cnapi"
    sql_on: ${cnapi.uuid} = ${vmapi.server_uuid} and ${cnapi.date_date} = ${vmapi.date_date} ;;
    type: full_outer
    relationship: many_to_one
  }
}
explore: cnapimonthly {
  description: "CNApi monthly"
  group_label: "Joyent Cloud"
  label: "cnapi monthly"
  join: datacenters {
    view_label: "DC"
    sql_on: ${datacenters.name} = ${cnapimonthly.dc} ;;
    type: left_outer
    relationship: many_to_one
  }

}

explore: jpcdaily_spend {
  description: "Billing Preview spend"
  group_label: "Joyent Cloud"
  label: "jpc daily spend"

    join: zuora_customers {
      view_label: "Customers"
      sql_on: ${jpcdaily_spend.accountnumber} = ${zuora_customers.accountnumber} ;;
      type: left_outer
      relationship: many_to_one
    }
    join: jpc_account_facts {
      view_label: "Customers"
      sql_on: ${jpcdaily_spend.accountnumber} = ${jpc_account_facts.account_number} ;;
      type: left_outer
      relationship: many_to_one
    }
    join: ufds {
      view_label: "Customers"
      sql_on: ${jpcdaily_spend.accountnumber} =  ${ufds.uuid}  ;;
      type: left_outer
      relationship: many_to_one
    }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on:  ${jpcdaily_spend.accountnumber} = ${ufdsgroupname.uuid}  ;;
    type: left_outer
    relationship: one_to_one
  }
}
explore: images {
  description: "Images"
  group_label: "Joyent Cloud"
  label: "Images"
}
explore: papi {
  description: "Package"
  group_label: "Joyent Cloud"
  label: "Packages"
}
explore: ufdsgroupname {
  description: "UFDS Groupname"
  group_label: "Joyent Cloud"
  label: "UFDS groups"
}
explore: makotomb {
  description: "SmartDC mako tombstone"
  group_label: "Joyent Cloud"
  label: "mako tombstone"
}
explore: mako {
  description: "SmartDC mako stats"
  group_label: "Joyent Cloud"
  label: "Mako"
  join: ufds {
    view_label: "Customers"
    sql_on: ${mako.account} =  ${ufds.uuid}  ;;
    type: left_outer
    relationship: one_to_one
  }
  join: ufdsgroupname{
    view_label: "Customer group"
    sql_on:  ${mako.account} = ${ufdsgroupname.uuid}  ;;
    type: left_outer
    relationship: one_to_one
  }
}

explore: makoregion {
  description: "SmartDC mako regions stats"
  group_label: "Joyent Cloud"
  label: "Mako Region"
  join: makoregiontomb {
    view_label: "region tombstone"
    sql_on: ${makoregion.storage_id} = ${makoregiontomb.storage_id}
    type: left_outer;;
    relationship: one_to_many
  }
}

explore: makoregiontomb {
  description: "SmartDC mako regions stats"
  group_label: "Joyent Cloud"
  label: "Mako Region tombstone"
}

explore: netbox {
  description: "SPC servers"
  group_label: "Joyent Cloud"
  label: "servers"
  join: cnapi {
    type: full_outer
    sql_on: ${cnapi.cn_name} = ${netbox.name} and ${cnapi.date_date} = ${netbox.date_date} ;;
    relationship: one_to_one
  }
  join: papi {
    view_label: "Packages"
    sql_on: ${cnapi.setup} = ${papi.active} ;;
    type:  full_outer
    relationship: many_to_one
  }
  join: datacenters {
    view_label: "DC"
    sql_on: ${datacenters.name} = ${netbox.site} ;;
    type: left_outer
    relationship: many_to_one
  }
}
explore: sdcdataloaded {
  description: "SmartDC Data loaded"
  group_label: "Dataloaded"
  label: "SmartDC stats"
}

explore: capdataloaded {
  description: "Capacity Data loaded"
  group_label: "Dataloaded"
  label: "Capacity stats"
}


label: "Joyent Cloud"

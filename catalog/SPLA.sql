SELECT 
--  a.id, 
  a.name as "Name", 
--  a.location_id, -- DEPRECATED
  b.name as "Location",
--  a.smc_location_id, -- REAL LOCATION ID NOW
  a.rack as "Rack", 
--  a.customer_id, 
--  a.smc_customer_id, 
--  a.managed_by_id,
  c.name as "Managed by",
--  a.manufacturer_id,
  e.name as "Manufacturer",
--  a.model_id, 
--  a.asset_type_id,
  f.name as "Asset type",
  a.serial_tag, 
--  a.asset_tag, 
--  a.service_address, 
--  a.service_city, 
--  a.service_state, 
--  a.os_type_id, 
  g.name as "OS type",
  a.os_version as "OS cersion", 
--  a.os_kernel, 
--  a.windows_sp, 
  a.status as "Status", 
  a.created_at as "Created at", 
--  a.created_by, 
  a.updated_at as "Updated at", 
  CASE WHEN LOWER(i.name) = 'expedient'
  THEN 'Expedient'
  ELSE 'Customer'
  END
  AS "Customer"
--  a.updated_by, 
--  a.region_id
--  h.name as REGION
FROM smc.asset a,
  smc.asset_location b,
  smc.asset_managed_by c,
  smc.asset_manufacturer e,
  smc.asset_type f,
  smc.asset_os_type g,
  smc.customer i
--  smc.asset_region h
where a.smc_location_id = b.smc_location_id
-- and LOWER(a.os_version) like '%microsoft%'
and g.name = 'Windows'
and a.status = 'Active'
and a.managed_by_id = c.id
and a.manufacturer_id = e.id
and a.asset_type_id = f.id
and a.os_type_id = g.id
-- and a.region_id = h.id
and LOWER(a.rack) != 'vm'
and LOWER(c.name) NOT LIKE '%vmware%'
and LOWER(e.name) NOT LIKE '%vmware%'
and a.customer_id = i.id;
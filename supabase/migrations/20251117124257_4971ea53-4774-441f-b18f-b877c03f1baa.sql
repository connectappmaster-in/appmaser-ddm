-- =============================================
-- CRM TABLES
-- =============================================

-- CRM Leads Table
CREATE TABLE public.crm_leads (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  tenant_id BIGINT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone VARCHAR(20),
  company VARCHAR(255),
  status VARCHAR(50) DEFAULT 'new' CHECK (status IN ('new', 'contacted', 'qualified', 'converted', 'lost')),
  source VARCHAR(100),
  assigned_to UUID,
  created_by UUID NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- CRM Deals Table
CREATE TABLE public.crm_deals (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  tenant_id BIGINT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  lead_id BIGINT REFERENCES public.crm_leads(id) ON DELETE SET NULL,
  title VARCHAR(255) NOT NULL,
  amount DECIMAL(12, 2),
  currency VARCHAR(3) DEFAULT 'INR',
  stage VARCHAR(50) CHECK (stage IN ('prospecting', 'qualification', 'proposal', 'negotiation', 'closed_won', 'closed_lost')),
  expected_close_date DATE,
  owner_id UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- CRM Contacts Table
CREATE TABLE public.crm_contacts (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  tenant_id BIGINT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone VARCHAR(20),
  company VARCHAR(255),
  status VARCHAR(50) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'archived')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- ASSETS TABLES
-- =============================================

-- Assets Table
CREATE TABLE public.assets (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  tenant_id BIGINT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  asset_type VARCHAR(100),
  purchase_date DATE NOT NULL,
  purchase_price DECIMAL(12, 2) NOT NULL,
  salvage_value DECIMAL(12, 2),
  useful_life_years INTEGER,
  depreciation_method VARCHAR(50) CHECK (depreciation_method IN ('straight_line', 'declining_balance', 'sum_of_years', 'units_of_production')),
  current_value DECIMAL(12, 2),
  status VARCHAR(50) DEFAULT 'active' CHECK (status IN ('active', 'disposed', 'sold', 'retired')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Depreciation Entries Table
CREATE TABLE public.depreciation_entries (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  tenant_id BIGINT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  asset_id BIGINT NOT NULL REFERENCES public.assets(id) ON DELETE CASCADE,
  period_date DATE NOT NULL,
  depreciation_amount DECIMAL(12, 2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- INVENTORY TABLES
-- =============================================

-- Inventory Items Table
CREATE TABLE public.inventory_items (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  tenant_id BIGINT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  sku VARCHAR(100),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  category VARCHAR(100),
  quantity_on_hand INTEGER DEFAULT 0,
  reorder_level INTEGER,
  unit_cost DECIMAL(10, 2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(tenant_id, sku)
);

-- Inventory Warehouses Table
CREATE TABLE public.inventory_warehouses (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  tenant_id BIGINT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Inventory Stock Table
CREATE TABLE public.inventory_stock (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  tenant_id BIGINT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  item_id BIGINT NOT NULL REFERENCES public.inventory_items(id) ON DELETE CASCADE,
  warehouse_id BIGINT NOT NULL REFERENCES public.inventory_warehouses(id),
  quantity INTEGER DEFAULT 0,
  last_counted TIMESTAMP WITH TIME ZONE,
  UNIQUE(tenant_id, item_id, warehouse_id)
);

-- =============================================
-- TICKETS TABLE
-- =============================================

CREATE TABLE public.tickets (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  tenant_id BIGINT NOT NULL REFERENCES public.tenants(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  status VARCHAR(50) DEFAULT 'open' CHECK (status IN ('open', 'in_progress', 'waiting', 'resolved', 'closed')),
  priority VARCHAR(50) CHECK (priority IN ('low', 'medium', 'high', 'urgent')),
  reporter_id UUID,
  assigned_to UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- ENABLE ROW LEVEL SECURITY
-- =============================================

ALTER TABLE public.crm_leads ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.crm_deals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.crm_contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.assets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.depreciation_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inventory_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inventory_warehouses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inventory_stock ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tickets ENABLE ROW LEVEL SECURITY;

-- =============================================
-- RLS POLICIES - CRM LEADS
-- =============================================

CREATE POLICY "Users can view leads in their tenant"
  ON public.crm_leads
  FOR SELECT
  USING (tenant_id = public.get_user_tenant(auth.uid()));

CREATE POLICY "Users can modify leads in their tenant"
  ON public.crm_leads
  FOR ALL
  USING (tenant_id = public.get_user_tenant(auth.uid()));

-- =============================================
-- RLS POLICIES - CRM DEALS
-- =============================================

CREATE POLICY "Users can view deals in their tenant"
  ON public.crm_deals
  FOR SELECT
  USING (tenant_id = public.get_user_tenant(auth.uid()));

CREATE POLICY "Users can modify deals in their tenant"
  ON public.crm_deals
  FOR ALL
  USING (tenant_id = public.get_user_tenant(auth.uid()));

-- =============================================
-- RLS POLICIES - CRM CONTACTS
-- =============================================

CREATE POLICY "Users can view contacts in their tenant"
  ON public.crm_contacts
  FOR SELECT
  USING (tenant_id = public.get_user_tenant(auth.uid()));

CREATE POLICY "Users can modify contacts in their tenant"
  ON public.crm_contacts
  FOR ALL
  USING (tenant_id = public.get_user_tenant(auth.uid()));

-- =============================================
-- RLS POLICIES - ASSETS
-- =============================================

CREATE POLICY "Users can view assets in their tenant"
  ON public.assets
  FOR SELECT
  USING (tenant_id = public.get_user_tenant(auth.uid()));

CREATE POLICY "Users can modify assets in their tenant"
  ON public.assets
  FOR ALL
  USING (tenant_id = public.get_user_tenant(auth.uid()));

-- =============================================
-- RLS POLICIES - DEPRECIATION ENTRIES
-- =============================================

CREATE POLICY "Users can view depreciation in their tenant"
  ON public.depreciation_entries
  FOR SELECT
  USING (tenant_id = public.get_user_tenant(auth.uid()));

CREATE POLICY "Users can modify depreciation in their tenant"
  ON public.depreciation_entries
  FOR ALL
  USING (tenant_id = public.get_user_tenant(auth.uid()));

-- =============================================
-- RLS POLICIES - INVENTORY ITEMS
-- =============================================

CREATE POLICY "Users can view inventory items in their tenant"
  ON public.inventory_items
  FOR SELECT
  USING (tenant_id = public.get_user_tenant(auth.uid()));

CREATE POLICY "Users can modify inventory items in their tenant"
  ON public.inventory_items
  FOR ALL
  USING (tenant_id = public.get_user_tenant(auth.uid()));

-- =============================================
-- RLS POLICIES - INVENTORY WAREHOUSES
-- =============================================

CREATE POLICY "Users can view warehouses in their tenant"
  ON public.inventory_warehouses
  FOR SELECT
  USING (tenant_id = public.get_user_tenant(auth.uid()));

CREATE POLICY "Users can modify warehouses in their tenant"
  ON public.inventory_warehouses
  FOR ALL
  USING (tenant_id = public.get_user_tenant(auth.uid()));

-- =============================================
-- RLS POLICIES - INVENTORY STOCK
-- =============================================

CREATE POLICY "Users can view stock in their tenant"
  ON public.inventory_stock
  FOR SELECT
  USING (tenant_id = public.get_user_tenant(auth.uid()));

CREATE POLICY "Users can modify stock in their tenant"
  ON public.inventory_stock
  FOR ALL
  USING (tenant_id = public.get_user_tenant(auth.uid()));

-- =============================================
-- RLS POLICIES - TICKETS
-- =============================================

CREATE POLICY "Users can view tickets in their tenant"
  ON public.tickets
  FOR SELECT
  USING (tenant_id = public.get_user_tenant(auth.uid()));

CREATE POLICY "Users can modify tickets in their tenant"
  ON public.tickets
  FOR ALL
  USING (tenant_id = public.get_user_tenant(auth.uid()));

-- =============================================
-- PERFORMANCE INDEXES
-- =============================================

-- CRM Indexes
CREATE INDEX idx_crm_leads_tenant ON public.crm_leads(tenant_id);
CREATE INDEX idx_crm_leads_status ON public.crm_leads(tenant_id, status);
CREATE INDEX idx_crm_leads_assigned ON public.crm_leads(tenant_id, assigned_to);
CREATE INDEX idx_crm_deals_tenant ON public.crm_deals(tenant_id);
CREATE INDEX idx_crm_deals_stage ON public.crm_deals(tenant_id, stage);
CREATE INDEX idx_crm_contacts_tenant ON public.crm_contacts(tenant_id);

-- Assets Indexes
CREATE INDEX idx_assets_tenant ON public.assets(tenant_id);
CREATE INDEX idx_assets_status ON public.assets(tenant_id, status);
CREATE INDEX idx_depreciation_tenant ON public.depreciation_entries(tenant_id);
CREATE INDEX idx_depreciation_asset ON public.depreciation_entries(asset_id);

-- Inventory Indexes
CREATE INDEX idx_inventory_items_tenant ON public.inventory_items(tenant_id);
CREATE INDEX idx_inventory_items_sku ON public.inventory_items(tenant_id, sku);
CREATE INDEX idx_inventory_warehouses_tenant ON public.inventory_warehouses(tenant_id);
CREATE INDEX idx_inventory_stock ON public.inventory_stock(tenant_id, warehouse_id);
CREATE INDEX idx_inventory_stock_item ON public.inventory_stock(item_id);

-- Tickets Indexes
CREATE INDEX idx_tickets_tenant ON public.tickets(tenant_id);
CREATE INDEX idx_tickets_status ON public.tickets(tenant_id, status);
CREATE INDEX idx_tickets_assigned ON public.tickets(tenant_id, assigned_to);

-- =============================================
-- AUTO-UPDATE TIMESTAMPS TRIGGERS
-- =============================================

CREATE TRIGGER update_crm_leads_updated_at
  BEFORE UPDATE ON public.crm_leads
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_crm_deals_updated_at
  BEFORE UPDATE ON public.crm_deals
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_crm_contacts_updated_at
  BEFORE UPDATE ON public.crm_contacts
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_assets_updated_at
  BEFORE UPDATE ON public.assets
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_inventory_items_updated_at
  BEFORE UPDATE ON public.inventory_items
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_tickets_updated_at
  BEFORE UPDATE ON public.tickets
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();
import { Link } from "react-router-dom";
import { Card } from "@/components/ui/card";
import { 
  TrendingDown, 
  FileText, 
  Clock, 
  Users, 
  Ticket, 
  CreditCard, 
  Package, 
  Wallet,
  Box,
  Building2,
  Megaphone,
  Receipt,
  Mail
} from "lucide-react";

const modules = [
  {
    category: "Finance",
    categoryClass: "bg-cyan-600 text-white",
    items: [
      { icon: TrendingDown, label: "Depreciation", path: "/depreciation" },
      { icon: FileText, label: "Invoicing", path: "/invoicing" },
    ],
  },
  {
    category: "HR",
    categoryClass: "bg-cyan-600 text-white",
    items: [
      { icon: Clock, label: "Attendance", path: "/attendance" },
      { icon: Users, label: "Recruitment", path: "/recruitment" },
    ],
  },
  {
    category: "IT",
    categoryClass: "bg-cyan-600 text-white",
    items: [
      { icon: Ticket, label: "Tickets Handling", path: "/tickets" },
      { icon: CreditCard, label: "Subscriptions", path: "/subscriptions" },
      { icon: Package, label: "Assets", path: "/assets" },
    ],
  },
  {
    category: "Shop",
    categoryClass: "bg-cyan-600 text-white",
    items: [
      { icon: Wallet, label: "Income & Expenditure Tracker", path: "/shop-income-expense" },
    ],
  },
  {
    category: "Manufacturing",
    categoryClass: "bg-cyan-600 text-white",
    items: [
      { icon: Box, label: "Inventory", path: "/inventory" },
    ],
  },
  {
    category: "Sales",
    categoryClass: "bg-cyan-600 text-white",
    items: [
      { icon: Building2, label: "CRM", path: "/crm" },
    ],
  },
  {
    category: "Marketing",
    categoryClass: "bg-cyan-600 text-white",
    items: [
      { icon: Megaphone, label: "Marketing", path: "/marketing" },
    ],
  },
  {
    category: "Productivity",
    categoryClass: "bg-cyan-600 text-white",
    items: [
      { icon: Receipt, label: "Personal Expense Tracker", path: "/personal-expense" },
    ],
  },
  {
    category: "Custom",
    categoryClass: "bg-cyan-600 text-white",
    items: [
      { icon: Mail, label: "Contact Us", path: "/contact" },
    ],
  },
];

const ModuleGrid = () => {
  return (
    <section className="py-6 md:py-12 px-4 pb-16 md:pb-24">
      <div className="container mx-auto max-w-7xl">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 md:gap-6">
          {modules.map((module, idx) => (
            <Card key={idx} className="overflow-hidden border-border hover:shadow-lg transition-shadow">
              <div className="flex min-h-[120px]">
                <div className={`${module.categoryClass} w-12 sm:w-14 md:w-16 flex items-center justify-center p-2 md:p-4`}>
                  <span className="writing-mode-vertical text-xs sm:text-sm font-semibold tracking-wider">
                    {module.category}
                  </span>
                </div>
                <div className="flex-1 p-4 md:p-6">
                  {module.items.map((item, itemIdx) => (
                    <Link
                      key={itemIdx}
                      to={item.path}
                      className="flex items-center gap-2 md:gap-3 py-2 md:py-3 text-foreground hover:text-primary transition-colors group"
                    >
                      <item.icon className="w-4 h-4 md:w-5 md:h-5 text-muted-foreground group-hover:text-primary transition-colors flex-shrink-0" />
                      <span className="text-xs sm:text-sm font-medium">{item.label}</span>
                    </Link>
                  ))}
                </div>
              </div>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
};

export default ModuleGrid;

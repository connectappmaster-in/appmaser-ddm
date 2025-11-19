import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { ChevronDown } from "lucide-react";
import logoImage from "@/assets/appmaster-logo.png";

const Navbar = () => {
  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-background border-b border-border">
      <div className="container mx-auto px-3 md:px-4 py-3 md:py-4 flex items-center justify-between">
        <div className="flex items-center gap-4 md:gap-8">
          <Link to="/" className="flex items-center">
            <img src={logoImage} alt="AppMaster" className="h-8 md:h-12 w-auto" />
          </Link>
          <DropdownMenu>
            <DropdownMenuTrigger className="hidden md:flex items-center gap-1 text-sm font-medium text-foreground hover:text-primary transition-colors">
              Products <ChevronDown className="w-4 h-4" />
            </DropdownMenuTrigger>
            <DropdownMenuContent align="start">
              <DropdownMenuItem asChild>
                <Link to="/crm">CRM</Link>
              </DropdownMenuItem>
              <DropdownMenuItem asChild>
                <Link to="/inventory">Inventory</Link>
              </DropdownMenuItem>
              <DropdownMenuItem asChild>
                <Link to="/invoicing">Invoicing</Link>
              </DropdownMenuItem>
              <DropdownMenuItem asChild>
                <Link to="/assets">Assets</Link>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </div>
        <div className="flex gap-2 md:gap-3">
          <Link to="/login">
            <Button variant="ghost" size="sm" className="md:size-default">Sign In</Button>
          </Link>
          <Link to="/login">
            <Button size="sm" className="md:size-default">Start Free</Button>
          </Link>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;

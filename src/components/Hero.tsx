import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";

const Hero = () => {
  return (
    <section className="pt-32 pb-16 px-4">
      <div className="container mx-auto text-center">
        <h1 className="text-5xl md:text-6xl font-bold mb-6 text-foreground">
          Your All-in-One Business Platform
        </h1>
        <p className="text-xl text-muted-foreground mb-8 max-w-2xl mx-auto">
          Manage your entire business from one powerful platform. CRM, inventory, invoicing, and more.
        </p>
        <Link to="/login">
          <Button size="lg" className="text-lg px-8">
            Start Free Trial
          </Button>
        </Link>
      </div>
    </section>
  );
};

export default Hero;

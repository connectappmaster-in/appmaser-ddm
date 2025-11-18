import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";

const CTA = () => {
  return (
    <section className="py-16 px-4">
      <div className="container mx-auto text-center">
        <h2 className="text-4xl font-bold mb-6 text-foreground">
          Ready to Get Started?
        </h2>
        <p className="text-xl text-muted-foreground mb-8">
          Join thousands of businesses using AppMaster
        </p>
        <Link to="/login">
          <Button size="lg" className="text-lg px-8">
            Start Your Free Trial
          </Button>
        </Link>
      </div>
    </section>
  );
};

export default CTA;

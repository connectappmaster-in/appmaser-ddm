import Navbar from "@/components/Navbar";
import Hero from "@/components/Hero";
import ModuleGrid from "@/components/ModuleGrid";

const Index = () => {
  return (
    <div className="min-h-screen w-full bg-background">
      <Navbar />
      <Hero />
      <ModuleGrid />
    </div>
  );
};

export default Index;
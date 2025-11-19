import Navbar from "@/components/Navbar";
import Hero from "@/components/Hero";
import ModuleGrid from "@/components/ModuleGrid";

const Index = () => {
  return (
    <div className="min-h-screen w-full bg-background flex flex-col">
      <Navbar />
      <main className="flex-1">
        <Hero />
        <ModuleGrid />
      </main>
    </div>
  );
};

export default Index;
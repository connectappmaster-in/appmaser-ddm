const Benefits = () => {
  return (
    <section className="py-16 px-4">
      <div className="container mx-auto">
        <h2 className="text-4xl font-bold text-center mb-12 text-foreground">
          Why Choose AppMaster?
        </h2>
        <div className="grid md:grid-cols-3 gap-8">
          <div className="text-center">
            <h3 className="text-2xl font-semibold mb-4 text-foreground">Easy to Use</h3>
            <p className="text-muted-foreground">
              Intuitive interface designed for business owners
            </p>
          </div>
          <div className="text-center">
            <h3 className="text-2xl font-semibold mb-4 text-foreground">Secure</h3>
            <p className="text-muted-foreground">
              Enterprise-grade security for your data
            </p>
          </div>
          <div className="text-center">
            <h3 className="text-2xl font-semibold mb-4 text-foreground">Scalable</h3>
            <p className="text-muted-foreground">
              Grows with your business needs
            </p>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Benefits;

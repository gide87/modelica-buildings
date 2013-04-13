within Buildings.Fluid.SolarCollectors.Data.GlazedFlatPlate;
record TRNSYSValidation =
    SolarCollectors.Data.GlazedFlatPlate.Generic (
    ATyp=Types.Area.Gross,
    Fluid=Types.DesignFluid.Water,
    A=5,
    mDry=8.6,
    V=0.6/1000,
    dp_nominal=1103*1000,
    VperA_flow_nominal=11.1/(10^6),
    B0=-0.2,
    B1=-0,
    y_intercept=0.8,
    slope=-3.6111,
    IAMDiff=0,
    C1=0,
    C2=0) "Default values in the TRNSYS Simulation Studio SDHW example"
    annotation(Documentation(info="<html>
    Default values in the TRNSYS Simualtion Studio SDHW example.</html>"));
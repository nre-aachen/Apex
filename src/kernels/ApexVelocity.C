/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*           (c) 2010 Battelle Energy Alliance, LLC             */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#include "ApexVelocity.h"


template<>
InputParameters validParams<ApexVelocity>()
{
  // Start with the parameters from our parent
  InputParameters params = validParams<Kernel>();
  params.addCoupledGradient("grad_p","Coupled presure field");
  params.addRequiredCoupledVar("u", "x-velocity");
  params.addCoupledVar("v", 0, "y-velocity"); // only required in 2D and 3D
  params.addCoupledVar("w", 0, "z-velocity"); // only required in 3D
  return params;
}


ApexVelocity::ApexVelocity(const InputParameters & parameters) :
    Diffusion(parameters),

    // Get the permeability and viscosity from the Material system
    // This returns a MaterialProperty<Real> reference that we store
    // in the class and then index into in computeQpResidual/Jacobian....
    _grad_pressure(coupledGradient("grad_p"))
{
}

ApexVelocity::~ApexVelocity()
{
}

Real
ApexVelocity::computeQpResidual()
{
  // Use the MaterialProperty references we stored earlier
  return _test[_i][_qp]*_u[_qp];
}

Real
ApexVelocity::computeQpJacobian()
{
  // Use the MaterialProperty references we stored earlier
  return _phi[_j][_qp]*_test[_i][_qp];
}

Real ApexVelocity::computeQpOffDiagJacobian()
{
  return 0;
}

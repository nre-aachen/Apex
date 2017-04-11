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

#ifndef APEXVELOCITY_H
#define APEXVELOCITY_H

// Including the "Diffusion" Kernel here so we can extend it
#include "Diffusion.h"

class ApexVelocity;

template<>
InputParameters validParams<ApexVelocity>();

/**
 * Represents K/mu * grad_u * grad_phi
 *
 * We are inheriting from Diffusion instead of from Kernel because
 * the grad_u * grad_phi is already coded in there and all we
 * need to do is specialize that calculation by multiplying by K/mu
 */
class ApexVelocity : public Diffusion
{
public:
  ApexVelocity(const InputParameters & parameters);
  virtual ~ApexVelocity();

protected:

  virtual Real computeQpResidual() override;


  virtual Real computeQpJacobian() override;

  virtual Real computeQpOffDiagJacobian() override;


  const VariableGradient & _grad_pressure;
};


#endif // ApexVelocity_H

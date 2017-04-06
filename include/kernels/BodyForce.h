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

#ifndef BODYFORCE_H
#define BODYFORCE_H

#include "Kernel.h"

// Forward Declaration
class BodyForce;

template<>
InputParameters validParams<BodyForce>();

/**
 * Kernel which implements the body force.
 */
class BodyForce : public Kernel
{
public:
  BodyForce(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual() override;

  //virtual Real computeQpJacobian() override;

  const Real & _gravity; 

  /// These references will be set by the initialization list so that
  /// values can be pulled from the Material system.
  
  const MaterialProperty<Real> & _density;
};

#endif // BODYFORCE_H

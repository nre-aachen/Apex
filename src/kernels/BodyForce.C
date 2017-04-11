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

#include "BodyForce.h"

template<>
InputParameters validParams<BodyForce>()
{
  InputParameters params = validParams<Kernel>();

  params.addParam<Real>("gravity",9.8,"Acceleration of gravity");

  return params;
}

BodyForce::BodyForce(const InputParameters & parameters) :
    Kernel(parameters),

    _gravity("gravity"),

    _density(getMaterialProperty<Real>("density"))

{
}

Real
BodyForce::computeQpResidual()
{

  return -_gravity[_qp] * _density[_qp] * _test[_i][_qp];
}

//Real
//BodyForce::computeQpJacobian()
//{
//  RealVectorValue superficial_velocity =
//    _porosity[_qp] * -(_permeability[_qp]/_viscosity[_qp]) * _pressure_gradient[_qp];

//  return _heat_capacity[_qp] * superficial_velocity * _grad_phi[_j][_qp] * _test[_i][_qp];
//}



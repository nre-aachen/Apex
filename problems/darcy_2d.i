[Mesh]
type = GeneratedMesh
dim = 2

nx = 10
ny = 10

xmin = 0.0
xmax = 1.0

ymin = 0.0
ymax = 1.0

elem_type = QUAD9
[]

[Variables]
  [./pressure]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./vel_y]
    order = FIRST
    family = LAGRANGE
  [../]
[]


[Kernels]
  [./mass_x]
    type = MassBalance
    variable = vel_x
    coupled_velocity = vel_y
    component = 0
  [../]

  [./mass_y]
    type = MassBalance
    variable = vel_y
    coupled_velocity = vel_x
    component = 1
  [../]

  [./u]
    type = DarcyVelocity
    variable = pressure
    velocity = vel_x
    component = 0
  [../]

  [./v]
    type = DarcyVelocity
    variable = pressure
    velocity = vel_y
    component = 1
  [../]
[]

[BCs]
  [./top_pressure]
    type = DirichletBC
    variable = pressure
    boundary = 'top'
    value = 0.0
  [../]

  [./bottom_pressure]
    type = DirichletBC
    variable = pressure
    boundary = 'bottom'
    value = 1.0
  [../]

  [./no_slip_vel_x]
    type = DirichletBC
    variable = vel_x
    boundary = 'top bottom left right'
    value = 0.0
  [../]

  [./no_slip_vel_y]
    type = DirichletBC
    variable = vel_y
    boundary = 'top bottom left right'
    value = 0.0
  [../]
[]

[Executioner]
  type = Steady
  solve_type = 'PJFNK'
  l_max_its = 100
  nl_max_its = 100
  #petsc_options = '-snes_mf_operator' #-ksp_monitor'
  #petsc_options_iname = '-pc_type -pc_hypre_type'
  #petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  execute_on = 'timestep_end'
  exodus = true
[]

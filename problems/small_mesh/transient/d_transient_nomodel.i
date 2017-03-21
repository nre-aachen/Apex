[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 10
  ny = 5
  nz = 8
 
  xmax = 100000 # 100 km
  ymax = 50000 # 50 km
  zmax = 8000 # 8 km
[]

[Variables]
  [./temperature]
  [../]
[]

[Kernels]
  [./heat_conduction]
    type = HeatConduction
    variable = temperature
  [../]
  [./heat_conduction_time_derivative]
    type = HeatConductionTimeDerivative
    variable = temperature
  [../]
[]

[BCs]
  [./inlet_temperature]
    type = DirichletBC
    variable = temperature
    boundary = left
    value = 350 # (K)
  [../]
  [./outlet_temperature]
    type = DirichletBC
    variable = temperature
    boundary = right
    value = 300 # (K)
  [../]
[]

[Materials]
  [./gneiss]
    type = GenericConstantMaterial
    block = 0
    prop_names = thermal_conductivity
    prop_values = 6.27 # K: (W/m*K) from https://pubs.usgs.gov/of/1988/0441/report.pdf @296K
  [../]
[]


[BCs]
  [./inlet_temperature]
    type = DirichletBC
    variable = temperature
    boundary = left
    value = 350 # (K)
  [../]
  [./outlet_temperature]
    type = HeatConductionOutflow
    variable = temperature
    boundary = right
  [../]
[]

[Problem]
  type = FEProblem
[]

[Executioner]
  type = Transient
  num_steps = 10
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  exodus = true
[]

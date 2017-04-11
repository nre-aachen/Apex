[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 10
  ny = 5
  nz = 8
  #block_id = '0 1 2'
  #block_name = 'gneiss steel ice'
  xmax = 100 # 100 km
  ymax = 50 # 50 km
  zmax = 30 # 8 km
[]

[MeshModifiers]
  [./simple_geomodel]
      type = AssignElementSubdomainID
      subdomain_ids = '1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 0 0 1 1 0 0 0 1 1 1 0 0 1 1 0 0 0 1 1 1 0 0 1 1 0 0 0 1 1 1 0 0 1 1 0 0 0 1 1 1 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 2 2 0 0 0 2 2 0 0 2 2 2 0 0 0 2 2 0 0 2 2 2 0 0 0 2 2 0 0 2 2 2 0 0 0 2 2 0 0 2 2 2 0 0 0 2 2 0 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 2 2 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2'
    [../]
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


[Materials]
  [./gneiss]
    type = GenericConstantMaterial
    block = 0
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '6.27 790 2650' # K: (W/m*K), J/Kg-K, kg/m3  from https://pubs.usgs.gov/of/1988/0441/report.pdf @300K
  [../]
  [./steel]
    type = GenericConstantMaterial
    block = 1
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '18 466 8000' # W/m*K, J/kg-K, kg/m^3 @ 296K from step5 of Darcy tutorial
  [../]
  [./ice]
    type = GenericConstantMaterial
    block = 2
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '2.22 2000 918.9' # K: (W/m*K), J/Kg-K, kg/m3 from http://www.engineeringtoolbox.com/ice-thermal-properties-d_576.html @296K
  [../]
[]


[BCs]
  [./inlet_temperature]
    type = DirichletBC
    variable = temperature
    boundary = bottom
    value = 473.15 # (K) using a temperature linear gradient of 25 ºC per Km
  [../]
  [./outlet_temperature]
    type = DirichletBC
    variable = temperature
    boundary = top
    value = 298.15 # (K) surface temperature at 25 ºC
  [../]
[]

[Problem]
  type = FEProblem
[]

[Executioner]
  type = Transient
  scheme = crank-nicolson
  num_steps = 30
  solve_type =  PJFNK
  ​line_searc h = basic
  petsc_options_iname = '-pc_type -sub_pc_type'
  petsc_options_value = 'asm lu'
  dt = 5
[]

[Outputs]
  exodus = true
[]

#### STEADY TEMPLATE - PERTH BASIN SECTION ####

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 28
  ny = 80
  nz = 28
  #block_id = '0 1 2 3 4 5 6 7 8 9 10 11 12'
  #block_name = 'Basement Cattamarra_Coal_Measures DefaultCover Eneabba_Fm Kockatea_Shale Late_Permian Lesueur_Ss Neocomian_Unc Topo_and_bathy Woodada_Fm Yarragadee_Fm Yigarn out'
  xmax = 90 # 100 km
  ymax = 60 # 50 km
  zmax = 80 # 8 km
[]

[MeshModifiers]
	[./perth_section]
  		type = AssignElementSubdomainID
  		subdomain_ids = [magic_key]
  	[../]
[]

[Variables]
  [./temperature]
  [../]
[]

[Functions]
  # A ParsedFunction allows us to supply analytic expressions
  # directly in the input file
  [./bc_func]
    type = ParsedFunction
    value = 298.15+(10/28)*grad*x
    vars = 'grad'
    vals = '1' # in future transform this to [grad_value] with deltax/nx calculated from the pythong script
  [../]
[]

[Kernels]
  [./heat_conduction]
    type = HeatConduction
    variable = temperature
  [../]
[]


[Materials]
# note: all thermal conductivity values with water satured at 30ºC
  [./basement]
    type = GenericConstantMaterial
    block = 0
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '3.2 980 2700' # K: (W/m*K), J/Kg-K, kg/m3  
  [../]
  [./cattamarra_Coal_Measures]
    type = GenericConstantMaterial
    block = 1
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '3.73 1000 2360' # W/m*K, J/kg-K, kg/m^3 
  [../]
  [./defaultCover]
    type = GenericConstantMaterial
    block = 2
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '3.73 1000 2360' # K: (W/m*K), J/Kg-K, kg/m3 # CHECK THESE VALUES
  [../]
  [./eneabba_Fm]
    type = GenericConstantMaterial
    block = 3
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '2.62 775 2520' # W/m*K, J/kg-K, kg/m^3 
  [../]
  [./kockatea_Shale]
    type = GenericConstantMaterial
    block = 4
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '2.09 900 2650' # W/m*K, J/kg-K, kg/m^3 
  [../]
  [./late_Permian]
    type = GenericConstantMaterial
    block = 5
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '3 900 2650' # W/m*K, J/kg-K, kg/m^3 
  [../]
  [./lesueur_Ss]
    type = GenericConstantMaterial
    block = 6
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '3.56 775 2650' # W/m*K, J/kg-K, kg/m^3 
  [../]
  #[./neocomian_Unc]
  #  type = GenericConstantMaterial
  #  block = 7
  #  prop_names = 'thermal_conductivity specific_heat density'
  #  prop_values = '3.73 1000 2360' # W/m*K, J/kg-K, kg/m^3   CHECK THESE VALUES
  #[../]
  #[./topo_and_bathy]
  #  type = GenericConstantMaterial
  #  block = 8
  #  prop_names = 'thermal_conductivity specific_heat density'
  #  prop_values = '3.73 1000 2360' # W/m*K, J/kg-K, kg/m^3    CHECK THESE VALUES
  #[../]
  [./woodada_Fm ]
    type = GenericConstantMaterial
    block = 9
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '2.79 850 2620' # W/m*K, J/kg-K, kg/m^3
  [../]
  [./yarragadee_Fm]
    type = GenericConstantMaterial
    block = 10
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '3.54 775 2180' # W/m*K, J/kg-K, kg/m^3 NOTE: AQUIFER VALUES
  [../]
  #[./yigarn]
  #  type = GenericConstantMaterial
  #  block = 11
  #  prop_names = 'thermal_conductivity specific_heat density'
  #  prop_values = '3.2 980 2700' # W/m*K, J/kg-K, kg/m^3 
  #[../]
  [./out]
    type = GenericConstantMaterial
    block = 12
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '3.2 980 2700' # W/m*K, J/kg-K, kg/m^3     CHECK THESE VALUES
  [../]
[]


[BCs]
  [./basin_top_temp]
    type = NeumannBC
    variable = temperature
    boundary = back
    value = -0.03
  [../]
  [./basin_bottom_temp]
    type = FunctionDirichletBC
    variable = temperature
    boundary = front
    function = bc_func
  [../]
[]

#[Problem]
#  type = FEProblem
#[]

[Executioner]

  #active='newton_solver'
  #[./newton_solver]
    type = Steady
    solve_type = NEWTON
  #[../]

  #[./pjfnk_solver]
  #  type = Steady
  #  solve_type =  PJFNK
  #  petsc_options_iname = '-pc_type -sub_pc_type'
  #  petsc_options_value = 'asm lu'
  #[../]
[]

[Outputs]
  exodus = true
[]

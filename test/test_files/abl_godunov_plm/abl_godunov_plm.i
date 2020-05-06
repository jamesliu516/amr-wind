#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#            SIMULATION STOP            #
#.......................................#
time.stop_time               =   22000.0     # Max (simulated) time to evolve
time.max_step                =   -1          # Max number of time steps

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#         TIME STEP COMPUTATION         #
#.......................................#
time.fixed_dt         =   0.5        # Use this constant dt if > 0
time.cfl              =   0.95         # CFL factor

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#            INPUT AND OUTPUT           #
#.......................................#
amr.KE_int = 1
io.line_plot_int = 1
time.plot_interval            =   500       # Steps between plot files
time.checkpoint_interval           =  -1000       # Steps between checkpoint files
amr.restart             =   ""          # Checkpoint to restart from 
amr.plt_tracer = 1

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#               PHYSICS                 #
#.......................................#
incflo.gravity          =   0.  0. -9.81  # Gravitational force (3D)
incflo.ro_0             = 1.0          # Reference density 

incflo.use_godunov = 1
incflo.use_ppm = 0
transport.viscosity = 1.0e-5
transport.laminar_prandtl = 0.7
transport.turbulent_prandtl = 0.3333
turbulence.model = Smagorinsky
Smagorinsky_coeffs.Cs = 0.135

incflo.physics = ABL
ICNS.source_terms = BoussinesqBuoyancy CoriolisForcing ABLForcing
BoussinesqBuoyancy.reference_temperature = 300.0
CoriolisForcing.latitude = 41.3
ABLForcing.abl_forcing_height = 90

incflo.ic_u = 6.128355544951824
incflo.ic_v = 5.142300877492314
incflo.ic_w = 0.0

abl.ntemperature = 3
abl.temperature_heights = 650.0 750.0 1000.0
abl.temperature_values = 300.0 308.0 308.75

abl.kappa = .41
abl.surface_roughness_z0 = 0.15

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#        ADAPTIVE MESH REFINEMENT       #
#.......................................#
amr.n_cell              = 48 48 48    # Grid cells at coarsest AMRlevel
amr.max_level           = 0           # Max AMR level in hierarchy 

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#              GEOMETRY                 #
#.......................................#
geometry.prob_lo        =   0.       0.     0.  # Lo corner coordinates
geometry.prob_hi        =   1000.  1000.  1000.  # Hi corner coordinates
geometry.is_periodic    =   1   1   0   # Periodicity x y z (0/1)

incflo.delp             =   0.  0.  0.  # Prescribed (cyclic) pressure gradient

# Boundary conditions
zlo.type =   "wall_model"
zlo.temperature = 0.0

zhi.type =   "slip_wall"
zhi.temperature = 0.003 # tracer is used to specify potential temperature gradient

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#              VERBOSITY                #
#.......................................#
incflo.verbose          =   0          # incflo_level

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨#
#              DEBUGGING                #
#.......................................#
amrex.fpe_trap_invalid  =   0           # Trap NaNs
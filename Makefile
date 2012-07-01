.SUFFIXES: .f90
LIBS    = /usr/lib/liblapack.so.3gf 

OBJ= global_constants.o global_simulation_parameter.o run_variables.o \
r_common.o fluid_variables.o solid_variables.o mpi_variables.o ale_variables.o \
delta_nonuniform.o \
ensight_output.o form.o \
meshgen_solid.o meshgen_fluid.o \
read.o parseinput.o correct.o  echoinput.o equal.o error.o \
facemap.o gaussj.o gjinv.o hg.o hypo.o initialize.o length.o main.o \
nondimension.o norm.o quad3d4n.o quad3d8n.o quad2d3n.o quad2d4n.o \
r_bdpd_curr.o r_bdpd_init.o r_element.o r_sbpress.o r_jacob.o r_load.o \
r_nodalf.o r_sboc.o r_scal.o r_scauchy.o r_smaterj.o  r_spiola.o \
r_spiola_viscous.o r_spiola_elastic.o r_spress.o r_sreadinit.o r_sstif.o \
r_sstrain.o r_stang.o r_stoxc.o r_timefun.o rkpmshape2d.o rkpmshape3d.o \
set.o shape.o solid_solver.o solid_update.o update.o vol.o \
data_exchange_FEM.o getinf_el_3d.o determinant.o inverse.o search_3d.o \
migs.o search_inf.o shx_tets.o energy_solid.o energy_fluid.o volcorr.o \
cg.o mergefinf.o readpart.o setnqloc.o search_inf_pa.o getinf_el_3d_pa.o \
edgeele.o nature_pre.o nature_pre_3d.o nature_totpre.o nature_totpre_3d.o \
givens.o \
communicate_res.o getnorm_pa.o equal_pa.o vector_dot_pa.o \
blockdiagstable.o gmresnew.o blockgmresnew.o \
setnei_new.o communicate_res_nei.o communicate_res_ad.o setid_pa.o \
solid_node_volume.o  source_laplace.o read_solidbc.o read_solidnodebc.o \
solid_normint.o outnormal_2d.o solid_normint_3d.o outnormal_tet.o outnormal_hex.o \
gmres_Laplace.o solve_laplace.o block_Laplace.o blockgmres_Laplace.o \
rkpm_nodevolume.o rkpm_init.o getinf_rkpm.o search_inf_re.o \
solve_solid_disp.o block_solid.o gmres_solid.o blockgmres_solid.o form_solidid.o \
setsolid_id.o res_solid.o block_solid_res.o apply_2ndbc_solid.o apply_2ndbc_solid2d.o \
readpart_solid.o solve_solid_disp_pa.o block_solid_pa.o gmres_solid_pa.o blockgmres_solid_pa.o \
solve_laplace_pa.o gmres_Laplace_pa.o \
bubblesort.o communicate_res_ad_sub.o bubblesort_solid.o communicate_res_ad_subsolid.o \
formd_time.o

IFEM: $(OBJ)
	mpif90 -g -O2 -o IFEM $(OBJ) $(LIBS)
.f90.o:
	mpif90 -c -g $<
clean:
	rm -rf *.o *.mod IFEM

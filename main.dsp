# Microsoft Developer Studio Project File - Name="main" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=main - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "main.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "main.mak" CFG="main - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "main - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "main - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
F90=df.exe
RSC=rc.exe

!IF  "$(CFG)" == "main - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE F90 /compile_only /nologo /warn:nofileopt
# ADD F90 /compile_only /nologo /warn:nofileopt
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib /nologo /subsystem:console /machine:I386

!ELSEIF  "$(CFG)" == "main - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE F90 /check:bounds /compile_only /debug:full /nologo /traceback /warn:argument_checking /warn:nofileopt
# ADD F90 /browser /check:bounds /check:format /check:power /check:output_conversion /check:overflow /compile_only /nologo /optimize:5 /threads /traceback /warn:argument_checking /warn:truncated_source /warn:unused
# SUBTRACT F90 /check:underflow /fltconsistency /warn:declarations /warn:nofileopt
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /ML /W4 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib /nologo /stack:0x5f5e100,0x989680 /subsystem:console /incremental:no /debug /machine:I386 /pdbtype:sept
# SUBTRACT LINK32 /verbose /profile /pdb:none

!ENDIF 

# Begin Target

# Name "main - Win32 Release"
# Name "main - Win32 Debug"
# Begin Source File

SOURCE=.\correct.f90
# End Source File
# Begin Source File

SOURCE=.\delta_nonuniform.f90
# End Source File
# Begin Source File

SOURCE=.\echoinput.f90
# End Source File
# Begin Source File

SOURCE=.\ensight_output.f90
DEP_F90_ENSIG=\
	".\fluid_variables.mod"\
	".\run_variables.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\error.f90
# End Source File
# Begin Source File

SOURCE=.\facemap.f90
DEP_F90_FACEM=\
	".\fluid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\fluid_variables.f90
# End Source File
# Begin Source File

SOURCE=.\gaussj.f90
# End Source File
# Begin Source File

SOURCE=.\gjinv.f90
# End Source File
# Begin Source File

SOURCE=.\global_constants.f90
# End Source File
# Begin Source File

SOURCE=.\global_simulation_parameter.f90
# End Source File
# Begin Source File

SOURCE=.\hypo.f90
DEP_F90_HYPO_=\
	".\delta_nonuniform.mod"\
	".\ensight_output.mod"\
	".\fluid_variables.mod"\
	".\global_constants.mod"\
	".\global_simulation_parameter.mod"\
	".\hypo_declaration_fluid.fi"\
	".\hypo_declaration_solid.fi"\
	".\hypo_prepare_solid.fi"\
	".\hypo_write_output.fi"\
	".\meshgen_fluid.mod"\
	".\meshgen_solid.mod"\
	".\r_common.mod"\
	".\run_variables.mod"\
	".\solid_fem_BC.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\hypo_declaration_fluid.fi
# End Source File
# Begin Source File

SOURCE=.\hypo_declaration_solid.fi
# End Source File
# Begin Source File

SOURCE=.\hypo_prepare_solid.fi
# End Source File
# Begin Source File

SOURCE=.\hypo_write_output.fi
# End Source File
# Begin Source File

SOURCE=.\initialize.f90
DEP_F90_INITI=\
	".\fluid_variables.mod"\
	".\run_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\input_solid_BC.in
# End Source File
# Begin Source File

SOURCE=.\main.f90
DEP_F90_MAIN_=\
	".\parseinput.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\meshgen_fluid.f90
DEP_F90_MESHG=\
	".\fluid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\meshgen_solid.f90
DEP_F90_MESHGE=\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\nondimension.f90
DEP_F90_NONDI=\
	".\fluid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\notes.txt
# End Source File
# Begin Source File

SOURCE=.\parseinput.f90
DEP_F90_PARSE=\
	".\delta_nonuniform.mod"\
	".\fluid_variables.mod"\
	".\global_simulation_parameter.mod"\
	".\meshgen_solid.mod"\
	".\r_common.mod"\
	".\run_variables.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\quad2d3n.f90
# End Source File
# Begin Source File

SOURCE=.\quad2d4n.f90
# End Source File
# Begin Source File

SOURCE=.\quad3d4n.f90
# End Source File
# Begin Source File

SOURCE=.\quad3d8n.f90
# End Source File
# Begin Source File

SOURCE=.\r_bdpd_curr.f90
DEP_F90_R_BDP=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_bdpd_init.f90
DEP_F90_R_BDPD=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_common.f90
# End Source File
# Begin Source File

SOURCE=.\r_element.f90
DEP_F90_R_ELE=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_jacob.f90
DEP_F90_R_JAC=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_load.f90
DEP_F90_R_LOA=\
	".\r_common.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_nodalf.f90
DEP_F90_R_NOD=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_sboc.f90
DEP_F90_R_SBO=\
	".\r_common.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_sbpress.f90
DEP_F90_R_SBP=\
	".\r_common.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_scal.f90
DEP_F90_R_SCA=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_scauchy.f90
DEP_F90_R_SCAU=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_smaterj.f90
DEP_F90_R_SMA=\
	".\r_common.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_spiola.f90
DEP_F90_R_SPI=\
	".\r_common.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_spiola_elastic.f90
DEP_F90_R_SPIO=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_spiola_viscous.f90
DEP_F90_R_SPIOL=\
	".\fluid_variables.mod"\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_spress.f90
DEP_F90_R_SPR=\
	".\r_common.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_sprestress.f90
# End Source File
# Begin Source File

SOURCE=.\r_sreadinit.f90
DEP_F90_R_SRE=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_sstif.f90
DEP_F90_R_SST=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_sstrain.f90
DEP_F90_R_SSTR=\
	".\r_common.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_stang.f90
DEP_F90_R_STA=\
	".\r_common.mod"\
	".\run_variables.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_stoxc.f90
DEP_F90_R_STO=\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\r_timefun.f90
DEP_F90_R_TIM=\
	".\global_constants.mod"\
	".\r_common.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\read.f90
# End Source File
# Begin Source File

SOURCE=.\rkpmshape2d.f90
# End Source File
# Begin Source File

SOURCE=.\rkpmshape3d.f90
# End Source File
# Begin Source File

SOURCE=.\run_variables.f90
# End Source File
# Begin Source File

SOURCE=.\shape.f90
DEP_F90_SHAPE=\
	".\fluid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\solid_fem_BC.f90
DEP_F90_SOLID=\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\solid_solver.f90
DEP_F90_SOLID_=\
	".\r_common.mod"\
	".\solid_fem_BC.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\solid_update.f90
DEP_F90_SOLID_U=\
	".\r_common.mod"\
	".\run_variables.mod"\
	".\solid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\solid_variables.f90
# End Source File
# Begin Source File

SOURCE=.\update.f90
DEP_F90_UPDAT=\
	".\fluid_variables.mod"\
	
# End Source File
# Begin Source File

SOURCE=.\vol.f90
DEP_F90_VOL_F=\
	".\fluid_variables.mod"\
	".\sh2d3n.h"\
	".\sh2d4n.h"\
	".\sh3d4n.h"\
	".\sh3d8n.h"\
	
# End Source File
# Begin Source File

SOURCE=.\vol2d3n.fi
# End Source File
# Begin Source File

SOURCE=.\vol2d4n.fi
# End Source File
# End Target
# End Project

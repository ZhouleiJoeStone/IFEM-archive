!     
!     adina input coordinate
!
subroutine r_input
  use global_simulation_parameter
  use solid_variables
  use delta_nonuniform, only: ndelta
  use r_common
  use error_memory

  implicit none
     
  
  real*8,allocatable :: coor_1(:,:)
  integer,allocatable :: nea_1(:,:)

  real*8 :: ftemp
  integer :: idummy

  integer :: i,j,k

  integer :: npout(100),npmax

 !...old variables, only read, but not used from main_common
  real*8  :: thic
  integer :: numint(mno),ninsk(mno)
  real*8  :: xang(mno)
  real*8  :: xome(10),fbacc(3)
  integer :: nnda,numela
  integer :: n_ibmfv,n_dispforce,n_ibmfem
  real*8  :: applyv,applyf,threshold
  integer :: numskew,intnum,numct
  integer :: ntether

!     print control
!     if ninit=1 initial condition
!     if initdir=1/2 initial disp/vel

!	read in coortable.in	
  open(1,file='coortable.in',status='old',action='read')
  write(*,*) 'reading coortable.in'


  read(1,*) ninit,initdir
  if (ninit.eq.1)   write(*,*) 'apply initial condition' 
  if (initdir.eq.1) write(*,*) 'apply initial displacement'
  if (initdir.eq.2) write(*,*) 'apply initial velocity'
!     if npr=1/0 plot.m gives the coor/dispc     if ntprint=1 time.m gives the timefunstion

  read(1,*) npr,npdis,ntprint

  do i=1,npr
     read(1,*) ndprint(i),nprint(i)
  enddo

 !...data input check and iteration control
 !...nbouc -- boundary change influence the distributed forces
  read(1,*) nbouc,nchkread
 !...Gauss integration point
  read(1,*) nint,nis
  write(*,*) 'number of gauss integration point=',nint
  write(*,*) 'number of nodes per element=',nis

 !...number of dimensions in the solid domain
  read(1,*) nsd_solid
  write(*,*) 'number of dimensions in the solid domain=',nsd_solid
 !...rigid body or not
  read(1,*) nrigid
  if (nrigid.eq.1) then
     write(*,*) 'treating the solid as a RIGID BODY'
  else
     write(*,*) 'treating the solid as a NON-RIGID BODY'
  endif

!cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
!cccccc from the original main_dat
  read(1,*) n_ibmfem, n_tec_ens, n_dispforce
  read(1,*) n_ibmfv,applyv,applyf
  write(*,*) 'applyv=',applyv
  write(*,*) 'applyf=',applyf

  read(1,*) npmax
  write(*,*) 'npmax=',npmax
  if (npmax .ne. 0) then
     do i=1,npmax
            read(1,*) npout(i)
     enddo
  endif

  read(1,*) threshold
  write(*,*) 'threshold=',threshold

  read(1,*) ndelta
  write(*,*) 'ndelta=',ndelta

!cccccccccccccccccccccccccccccccccccccccccccccc
!	
!     use ibm information
!
  read(1,*) nn_solid_1,ne_solid_1,nnda,numela
  read(1,*) nump
  read(1,*) n_solid
  if (n_solid .gt. n_solid_max) then
     write(*,*) 'BOOST n_solid_max in r_common'
     stop
  endif

  nn_solid = nn_solid_1 * n_solid
  ne_solid = ne_solid_1 * n_solid

!	if (n_solid .gt.1) then
  do i=1,n_solid
     read(1,*) shift(1,i),shift(2,i),shift(3,i)
  enddo
!	endif

  write(*,*) 'number of nodes    (for one object)  = ',nn_solid_1
  write(*,*) 'number of elements (for one object)  = ',ne_solid_1
  write(*,*) 'number of multiple defined solids    = ',n_solid
  write(*,*) 'number of nodes    (all objects)     = ',nn_solid
  write(*,*) 'number of elements (all objects)     = ',ne_solid

  call solid_variables_initialize

  allocate(nea_1(ne_solid_1,nis),stat=error_id);        call alloc_error("nea_1","r_input",error_id)
  allocate(coor_1(nn_solid_1,nsd_solid),stat=error_id); call alloc_error("coor_1","r_input",error_id)

  do i=1,ne_solid_1
     read(1,*) idummy,(nea_1(i,k),k=1,nis)
	   !if (i < 40) then
	   !    write(*,*) nea_1(i,1)
	   !endif
  enddo
	
!
! for 2-D case only 
  do j=1,nn_solid_1
     read(1,*) idummy,(coor_1(j,i),i=1,3), idummy
  enddo
  coor_1(:,1:3)=coor_1(:,1:3)*solid_scale


  do i=1,n_solid
     solid_coor_init(1,nn_solid_1*(i-1)+1:nn_solid_1*i) = coor_1(1:nn_solid_1,1) + shift(1,i)
     solid_coor_init(2,nn_solid_1*(i-1)+1:nn_solid_1*i) = coor_1(1:nn_solid_1,2) + shift(2,i)
     solid_coor_init(3,nn_solid_1*(i-1)+1:nn_solid_1*i) = coor_1(1:nn_solid_1,3) + shift(3,i)
     nea(ne_solid_1*(i-1)+1:ne_solid_1*i,1:nis) = nea_1(1:ne_solid_1,1:nis) + (i-1)*nn_solid_1
  enddo
      
  deallocate(nea_1,stat=error_id);  call dealloc_error("nea_1","r_input",error_id)
  deallocate(coor_1,stat=error_id); call dealloc_error("coor_1","r_input",error_id)

  !nnd=nnd*n_solid
  !numel=numel*n_solid

  read(1,*) numskew,numgb,intnum,numct
  write(*,*) 'numgb=',numgb

  ntether=0
  do j=1,numgb
     read(1,*) ndirgb(j)
     read(1,*) numdir(j)
     do k=1,numdir(j)
        read(1,*) nodegb(j,k),nxt(1,nodegb(j,k)),nxt(2,nodegb(j,k)),nxt(3,nodegb(j,k))
	 enddo

     if (ndirgb(j) .eq. 111111) then
        do i=1,numdir(j)
           if (nxt(1,nodegb(j,i)) .ne. 0) then
              ntether=ntether+1
           endif
           if (nxt(2,nodegb(j,i)) .ne. 0) then
              ntether=ntether+1
           endif
           if (nxt(3,nodegb(j,i)) .ne. 0) then
              ntether=ntether+1
           endif
        enddo
     endif
  enddo  

 !...skew system
  write(*,*) 'number of tether points=',ntether
  do i=1,intnum
     read(1,*) numint(i),ninsk(i)
  enddo
  do i=1,numskew
     read(1,*) xang(i)
  enddo

 !...slave and master nodes
  do i=1,numct

  enddo

 !...time step
  read(1,*) ntfun

 !...data print out step
  read(1,*) nina

 !...pressure force
  read(1,*) numfn,numeb      
  do i=1,numeb
     read(1,*) nbe(i),nface(i),boup(i,1),boup(i,2),boup(i,3)
  enddo

 !...concentrated force
  do i=1,numfn
     read(1,*) nodefn(i),ndirfn(i),ftemp
     fnod(nodefn(i),ndirfn(i)) = ftemp*1.0d5
  enddo

 !...body force
  read(1,*) fbacc(1),fbacc(2),fbacc(3)
  write(*,*) 'body force=',fbacc(1),'i+',fbacc(2),'j'

 !...time functions
  do i=1,3
      read(1,*) nfuns(i)
      if (nfuns(i) .eq. 2) then
         read(1,*) xome(i)
      endif
  enddo

  read(1,*) thic,nreact
  if (nreact .eq. 1) then
     read(1,*) nrtp
     do i=1,nrtp
        read(1,*) ndraf(i),nraf(i)
     enddo
  endif
  read(1,*) rc1,rc2,rk,density_solid

!
!     in units
!
  read(1,*) xk,xtedis,xstretch,xvisc,xviss
  write(*,*) 'xk     = ',xk
  write(*,*) 'xtedis = ',xtedis
  write(*,*) 'xvisc  = ',xvisc
  write(*,*) 'xviss  = ',xviss

  read(1,*) vnorm,fnorm,vtol,ftol
  read(1,*) alpha_solid,beta_solid

  read(1,*) xmg1,xmg2,xmg3  !gravity

  write(*,*) 'xmg1=',xmg1
  write(*,*) 'xmg2=',xmg2
  write(*,*) 'xmg3=',xmg3

  close(1)

  return
end subroutine r_input
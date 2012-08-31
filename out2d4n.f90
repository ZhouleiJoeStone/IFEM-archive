subroutine out2d4n(rng,d,ien,xglobal,p)
! This subroutine is to apply B.C. du/dx=0 for 2D-4Node elements

use fluid_variables, only:mapping, neface, nnface, etype, ne, nn, nsd, nen, ndf,outedge
implicit none
integer rng(neface,ne) ! mrng matrix, for this case I know neface=4
integer ien(nen,ne)
real(8) xglobal(nsd,nn) ! global node cooridnates 
real(8) p(ndf,nn) ! residual vector passed in
real(8) d(nsd,nn) ! solution variables on the nodes

integer local_node(2) !local node index who sit on the boudary
real(8) xref(nsd,nen) ! local coordinates for the quad element
real(8) xq(nsd)   ! local cooridnates of middle point on the picked edge 
real(8) sq(0:nsd,nen) 
real(8) sh(0:nsd,nen) ! shape functions
real(8) xr(nsd,nsd),cf(nsd,nsd),sx(nsd,nsd)
real(8) det
real(8) x(nsd,nen) ! global node cooridnates on the local element nodes
real(8) du(nsd)   ! spacial derivative of the velocity
real(8) dl ! length of the edge
real(8) d_local(ndf,nen)

integer ie
integer iface
integer node
integer i,j

! node 1
xref(1,1) = -1.0
xref(2,1) = -1.0
!node 2
xref(1,2) =  1.0
xref(2,2) = -1.0
!node 3
xref(1,3) =  1.0
xref(2,3) =  1.0
!node 4
xref(1,4) = -1.0
xref(2,4) =  1.0




do ie=1,ne ! loop over element
	do iface=1,neface ! loop over element edges
		if ( rng(iface,ie) == outedge) then ! find the element edge on the boundary
			local_node(1:2)=mapping(1:2,iface,etype) ! get local node index on the boudnary
			
			do i=1,2
				node = ien(local_node(i),ie)
				p(1,node) = 0.0d0     ! set the residual in x direction as zero 
			end do
		end if
	end do
	
end do


do ie=1,ne ! loop over element
        do iface=1,neface ! loop over element edges
		if ( rng(iface,ie) == outedge) then ! find the element edge on the boundary
			local_node(1:2)=mapping(1:2,iface,etype) ! get local node index on the boudnary                        
			
			xq(:)=0.0d0
			
			do i=1,2
				node = ien(local_node(i),ie)
				xq(:) = xq(:) + xref(:,node)
			end do

			do i=1,nen
				node = ien(i,ie)
				x(:,i) = xglobal(:,node)
				d_local(:,i) = d(:,node)
			end do

			xq(:) = xq(:) / 2.0 ! get local the cooridnates of the middle point at the edge

			sq(0,1) = (1 - xq(1)) * (1 - xq(2)) / 4
			sq(0,2) = (1 + xq(1)) * (1 - xq(2)) / 4
			sq(0,3) = (1 + xq(1)) * (1 + xq(2)) / 4
			sq(0,4) = (1 - xq(1)) * (1 + xq(2)) / 4
			sq(1,1) = - (1 - xq(2)) / 4
			sq(1,2) = + (1 - xq(2)) / 4
			sq(1,3) = + (1 + xq(2)) / 4
			sq(1,4) = - (1 + xq(2)) / 4
			sq(2,1) = - (1 - xq(1)) / 4
			sq(2,2) = - (1 + xq(1)) / 4
			sq(2,3) = + (1 + xq(1)) / 4
			sq(2,4) = + (1 - xq(1)) / 4
			! calcualte the shape funciton based on the middle point

			sh(0,1) = sq(0,1)
			sh(0,2) = sq(0,2)
			sh(0,3) = sq(0,3)
			sh(0,4) = sq(0,4)
			xr(1,1) = sq(1,1) * x(1,1) + sq(1,2) * x(1,2) &
			+ sq(1,3) * x(1,3) + sq(1,4) * x(1,4)
			xr(1,2) = sq(1,1) * x(2,1) + sq(1,2) * x(2,2) &
			+ sq(1,3) * x(2,3) + sq(1,4) * x(2,4)
			xr(2,1) = sq(2,1) * x(1,1) + sq(2,2) * x(1,2) &
			+ sq(2,3) * x(1,3) + sq(2,4) * x(1,4)
			xr(2,2) = sq(2,1) * x(2,1) + sq(2,2) * x(2,2) &
			+ sq(2,3) * x(2,3) + sq(2,4) * x(2,4)

				!  jacobian
    			cf(1,1) = + (xr(1,1)*xr(2,2) - xr(2,1)*xr(1,2))

        		det = cf(1,1)

	        	sx(1,1) = xr(2,2)/det
		        sx(1,2) = -xr(1,2)/det
		        sx(2,1) = -xr(2,1)/det
		        sx(2,2) = xr(1,1)/det
				!  global first derivatives
    			sh(1,1)= sq(1,1) * sx(1,1) + sq(2,1) * sx(1,2)
        		sh(1,2)= sq(1,2) * sx(1,1) + sq(2,2) * sx(1,2)
	    		sh(1,3)= sq(1,3) * sx(1,1) + sq(2,3) * sx(1,2)
	            	sh(1,4)= sq(1,4) * sx(1,1) + sq(2,4) * sx(1,2)
		        sh(2,1)= sq(1,1) * sx(2,1) + sq(2,1) * sx(2,2)
			sh(2,2)= sq(1,2) * sx(2,1) + sq(2,2) * sx(2,2)
			sh(2,3)= sq(1,3) * sx(2,1) + sq(2,3) * sx(2,2)
		        sh(2,4)= sq(1,4) * sx(2,1) + sq(2,4) * sx(2,2)
			! get the first derivative of the shape function

			du(:) = 0.0d0
			do i=1,nen
				do j=1,nsd
				du(j) = du(j) + sh(j,i) * d_local(1,i)
				end do
			end do
			! get du/dx and du/dy

			dl=0.0d0
			do j=1,nsd
			dl = dl + ( x(j,local_node(1)) - x(j,local_node(2)) )**2
			end do
			dl = sqrt(dl)
			! get the length of the edge
			
			do i=1,2
			node = ien(local_node(i), ie)
			p(1,node) = p(1,node) + du(1)*dl*0.5
			end do
			! distribute dl*dudx on the global nodes
		end if
	end do
end do



end


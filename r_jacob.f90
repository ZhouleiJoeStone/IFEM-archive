!     
!     jacobian calculation
!     
subroutine r_jacob(x,xj,xji,det)
  use r_common
  implicit none

  real*8 :: x(3,9),xj(3,3),xji(3,3),cf(3,3)
  real*8,intent(out) :: det


  real*8  :: dum
  integer :: i,j,k

 !...compute the jacobians
  do i=1,3
     do j=1,3
        dum=0.0d0
        do k=1,nis
           dum=dum+r_p(j,k)*x(i,k)
        enddo
        xj(i,j)=dum
	 enddo
  enddo
 !...compute the determinant of the jacobian matrix
 !...3-D determinant
  cf(1,1) = + (xj(2,2)*xj(3,3) - xj(2,3)*xj(3,2))
  cf(1,2) = - (xj(2,1)*xj(3,3) - xj(2,3)*xj(3,1))
  cf(1,3) = + (xj(2,1)*xj(3,2) - xj(2,2)*xj(3,1))
  cf(2,1) = - (xj(1,2)*xj(3,3) - xj(1,3)*xj(3,2))
  cf(2,2) = + (xj(1,1)*xj(3,3) - xj(1,3)*xj(3,1))
  cf(2,3) = - (xj(1,1)*xj(3,2) - xj(1,2)*xj(3,1))
  cf(3,1) = + (xj(1,2)*xj(2,3) - xj(1,3)*xj(2,2))
  cf(3,2) = - (xj(1,1)*xj(2,3) - xj(1,3)*xj(2,1))
  cf(3,3) = + (xj(1,1)*xj(2,2) - xj(1,2)*xj(2,1))

  det =( xj(1,1) * cf(1,1) + &
         xj(1,2) * cf(1,2) + &
		 xj(1,3) * cf(1,3) )

  if (det .lt. 1.0d-15) then
     write(*,100) 
     stop
  endif
100 format(6x, 'error, zero or negative jacobian determinant')


!...compute the inverse of the jacobian matrix

!      xji(1,1) = cf(1,1)/det
!      xji(1,2) = cf(2,1)/det
!      xji(1,3) = cf(3,1)/det
!      xji(2,1) = cf(1,2)/det
!      xji(2,2) = cf(2,2)/det
!      xji(2,3) = cf(3,2)/det
!      xji(3,1) = cf(1,3)/det
!      xji(3,2) = cf(2,3)/det
!      xji(3,3) = cf(3,3)/det

  xji(1,1) = cf(1,1)/det
  xji(1,2) = cf(2,1)/det
  xji(1,3) = cf(3,1)/det
  xji(2,1) = cf(1,2)/det
  xji(2,2) = cf(2,2)/det
  xji(2,3) = cf(3,2)/det
  xji(3,1) = cf(1,3)/det
  xji(3,2) = cf(2,3)/det
  xji(3,3) = cf(3,3)/det
 
 !write(*,*) 'xji=',xji(1,2),xji(2,1),xji(3,3)
 
  return
end subroutine r_jacob

c	cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c	S. Aliabadi                                                          c
c	cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
	subroutine blockgmresm(xloc,dloc,p,ien)

	implicit none
	include "global.h"

	integer ien(nen,nec)
	real* 8 xloc(nsd,nn_loc)
	real* 8 dloc(nsd,nn_loc)
	real* 8 p(nsd,nn_loc)

	real* 8 x(nsdpad,nenpad)
	real* 8 d(nsdpad,nenpad)

	real* 8 eft0,det,eft1
	real* 8 sh(0:nsdpad,nenpad),ph(0:nsdpad,nenpad)
	real* 8 xr(nsdpad,nsdpad),cf(nsdpad,nsdpad),sx(nsdpad,nsdpad)

	real* 8 drx(nsdpad),dry(nsdpad),drz(nsdpad)
	real* 8 ttt,txx,txy,txz,tyx,tyy,tyz,tzx,tzy,tzz
	real* 8 mu,la,landa_over_mu
	integer inl, ie, isd, idf, iq, node



	mu = 1.0
	la = mu * landa_over_mu
        do ie=1,nec 
	   do inl=1,nen
	      do isd=1,nsd
		 x(isd,inl) = xloc(isd,ien(inl,ie))
		 d(isd,inl) = dloc(isd,ien(inl,ie))
	      enddo
	   enddo
	   do iq=1,nquad
	      if (nen.eq.4) then
		 include "sh3d4n.h"
	      else if (nen.eq.8) then
		 include "sh3d8n.h"
	      end if

	      eft0 = abs(det) * wq(iq)
c	      eft0 = wq(iq)
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c        CALCULATE k*delta(d)
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c.........  initialize variables
	      do isd = 1,nsd
		 drx(isd) = 0.0
		 dry(isd) = 0.0
		 drz(isd) = 0.0
	      enddo
	      
	      do inl=1,nen
c............... calculate the first derivative
		 do isd=1,nsd
		    drx(isd)=drx(isd)+sh(1,inl)*d(isd,inl)      
		    dry(isd)=dry(isd)+sh(2,inl)*d(isd,inl)      
		    drz(isd)=drz(isd)+sh(3,inl)*d(isd,inl)    
		 enddo
	      enddo
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
	      do inl=1,nen
		 ph(1,inl) = sh(1,inl)*eft0
		 ph(2,inl) = sh(2,inl)*eft0
		 ph(3,inl) = sh(3,inl)*eft0
	      enddo

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c.....Galerkin Terms (Look at notes)
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
	      ttt = la*(drx(xsd)+dry(ysd)+drz(zsd))
	      txx = mu*(drx(xsd)+drx(xsd))
	      tyx = mu*(dry(xsd)+drx(ysd))
	      tzx = mu*(drz(xsd)+drx(zsd))
	      txy = mu*(drx(ysd)+dry(xsd))
	      tyy = mu*(dry(ysd)+dry(ysd))
	      tzy = mu*(drz(ysd)+dry(zsd))
	      txz = mu*(drx(zsd)+drz(xsd))
	      tyz = mu*(dry(zsd)+drz(ysd))
	      tzz = mu*(drz(zsd)+drz(zsd))
       
	      do inl=1,nen
		 node=ien(inl,ie)
c.....Elastic Equation (calculate k*(delta(d))=p)
		 p(xsd,node) = p(xsd,node) +
	1	      ph(xsd,inl) * ttt +
	2	      ph(xsd,inl) * txx +
	3	      ph(ysd,inl) * tyx +
	4	      ph(zsd,inl) * tzx 
		 p(ysd,node) = p(ysd,node) +
	1	      ph(ysd,inl) * ttt +
	2	      ph(xsd,inl) * txy +
	3	      ph(ysd,inl) * tyy +
	4	      ph(zsd,inl) * tzy 
		 p(zsd,node) = p(zsd,node) +
	1	      ph(zsd,inl) * ttt +
	2	      ph(xsd,inl) * txz +
	3	      ph(ysd,inl) * tyz +
	4	      ph(zsd,inl) * tzz 
	      enddo
	   enddo
	enddo
      return
      end




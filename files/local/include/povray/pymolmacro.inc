//
//  PYMOLMACRO.INC v0.2
//
//  (c)2005 Tsjerk Wassenaar, University of Groningen
//
//  This include file for Povray contains
//  just a few macros which together allow
//  the conversion between the model space
//  (cartesian coordinates) and the Pymol
//  camera space.
//
//  With these macros one can easily combine
//  a Pymol scene with objects defined in the
//  coordinate space of the original
//  structure file.
//
//  The input consists of the output of the
//  get_view() command in Pymol. This output
//  consists of 18 floating point numbers
//  defining a rotation matrix and shift
//  vectors for the origin of rotation and
//  for the camera position.
//
//  The macro PYMOL_VIEW loads a
//  view obtained from Pymol.
//
//  It #declares two transformation statements:
//
//  FROM_PYMOL_VIEW
//  TO_PYMOL_VIEW
//
//  The first can be used to transform the Pymol
//  scene back to model (normal) space, the latter
//  is used to transform other objects to appear in
//  the scene on the correct position.
//
//  Additionally four macros are defined to transform
//  vectors (points) from one space to another:
//
//  VEC2PYMOLSPACE( <x, y, z> )
//  VEC2CARTSPACE( <x, y, z> )
//  VEC2PYMOLVEC( <x, y, z> )
//  VEC2CARTVEC( <x, y, z> )
//
//  *NEW*
//
//  If the view from pymol is stored as an array:
//
//  #declare M = array[18] {...}
//
//  then the macros
//
//  SET_PYMOL_VIEW
//    and
//  UNSET_PYMOL_VIEW
//
//  can be used directly to transform objects to and from that view:
//  object { ... SET_PYMOL_VIEW( M ) }
//
//  This is especially useful if multiple views are defined
//  and the scene was set in one:
//
//  #declare VIEW1 = M;
//  #declare VIEW2 = N;
//  union { #include "file.inc" UNSET_PYMOL_VIEW( M ) SET_PYMOL_VIEW( N ) }
//
//  NOTE: transform statements are combined by POV-Ray prior to
//  transformations of objects, so there's little need to implement a macro
//  SWITCH_PYMOL_VIEW( M, N )
//  although that would appear simpler in the scenes

//  Tsjerk A. Wassenaar
//  February 16, 2005
//  April 5, 2005
//  September 2, 2009
//

// Determinant of a matrix
//------------------------
#macro DET( M )

  #local a = M[0] * ( M[4]*M[8] - M[5]*M[7] );
  #local b = M[1] * ( M[3]*M[8] - M[5]*M[6] );
  #local c = M[2] * ( M[3]*M[7] - M[4]*M[6] );

  (a - b + c)

#end // of DET()


// The inverse of a matrix
//------------------------
#macro INV( m11, m12, m13, m21, m22, m23, m31, m32, m33 )

  #local M = array[9] { m11, m12, m13, m21, m22, m23, m31, m32, m33 };
  #local invdet = 1/DET( M );

  #local t11 = invdet * ( m22*m33 - m23*m32 );
  #local t12 = invdet * ( m13*m32 - m12*m33 );
  #local t13 = invdet * ( m12*m23 - m13*m22 );
  #local t21 = invdet * ( m23*m31 - m21*m33 );
  #local t22 = invdet * ( m11*m33 - m13*m31 );
  #local t23 = invdet * ( m13*m21 - m11*m23 );
  #local t31 = invdet * ( m21*m32 - m22*m31 );
  #local t32 = invdet * ( m12*m31 - m11*m32 );
  #local t33 = invdet * ( m11*m22 - m12*m21 );

  t11, t12, t13, t21, t22, t23, t31, t32, t33, 0, 0, 0

#end // of INV()

#macro M_INV( M )
  #local invdet = 1/DET( M );

  #local t11 = invdet * ( M[4]*M[8] - M[5]*M[7] );
  #local t21 = invdet * ( M[2]*M[7] - M[1]*M[8] );
  #local t31 = invdet * ( M[1]*M[5] - M[2]*M[4] );

  #local t12 = invdet * ( M[5]*M[6] - M[3]*M[8] );
  #local t22 = invdet * ( M[0]*M[8] - M[2]*M[6] );
  #local t32 = invdet * ( M[2]*M[3] - M[0]*M[5] );

  #local t13 = invdet * ( M[3]*M[7] - M[4]*M[6] );
  #local t23 = invdet * ( M[1]*M[6] - M[0]*M[7] );
  #local t33 = invdet * ( M[0]*M[4] - M[1]*M[3] );

  array[9] {t11, t12, t13, t21, t22, t23, t31, t32, t33}
#end

#macro MV_MUL( M, V )
    < M[0]*V.x + M[1]*V.y + M[2]*V.z,
      M[3]*V.x + M[4]*V.y + M[5]*V.z,
      M[6]*V.x + M[7]*V.y + M[8]*V.z >
#end

#macro SET_PYMOL_VIEW( M )
  transform {
    translate -< M[12], M[13], M[14] >
    matrix < M[0], M[1],  M[2],
         M[3], M[4],  M[5],
         M[6], M[7],  M[8],
         M[9], M[10], M[11] >
  }
#end // of SET_PYMOL_VIEW

#macro UNSET_PYMOL_VIEW( M )
  transform {
    translate -< M[9], M[10], M[11] >
    matrix < INV( M[0], M[1], M[2], M[3], M[4], M[5], M[6], M[7], M[8] ) >
    translate < M[12], M[13], M[14] >
  }
#end // of UNSET_PYMOL_VIEW

#macro C2P_VEC( M, vec)
  #local nvec = vec - <M[12],M[13],M[14]>;
  #local nvec =
    < M[0]*nvec.x + M[1]*nvec.y + M[2]*nvec.z,
      M[3]*nvec.x + M[4]*nvec.y + M[5]*nvec.z,
      M[6]*nvec.x + M[7]*nvec.y + M[8]*nvec.z >;
  nvec + <M[9],M[10],M[11]>
#end

#macro P2C_VEC( M, vec)
  MV_MUL( M_INV(M), vec - <M[9],M[10],M[11]> ) + <M[12],M[13],M[14]>
  //#local nvec = vec - <M[9],M[10],M[11]>;
  //#local N = M_INV( M ) ;
  //#local nvec =
  //  < N[0]*nvec.x + N[1]*nvec.y + N[2]*nvec.z,
  //    N[3]*nvec.x + N[4]*nvec.y + N[5]*nvec.z,
  //    N[6]*nvec.x + N[7]*nvec.y + N[8]*nvec.z >;
  //nvec
#end


#macro PYMOL_VIEW( r11, r12, r13,     // 3x3 Rotation matrix (Model space to camera space)
           r21, r22, r23,
           r31, r32, r33,
            c1,  c2,  c3,     // Vector from camera position to OOR position (camera space)
            o1,  o2,  o3,     // OOR position (model space)
            s1,  s2,  or)     // Slab near and far distance from camera, orthoscopic flag (±) and field of view (abs(or))

  #declare PYMOLVIEW_RMATRIX = array[9] { r11, r12, r13,
                      r21, r22, r23,
                      r31, r32, r33 }
  #declare PYMOLVIEW_CAMPOS  = < c1, c2, c3 >;
  #declare PYMOLVIEW_ORGPOS  = < o1, o2, o3 >;

  #declare TO_PYMOL_VIEW = transform {
    translate -< o1, o2, o3 >
    matrix < r11, r12, r13,
         r21, r22, r23,
         r31, r32, r33,
          c1,  c2,  c3 >
  }

  #declare FROM_PYMOL_VIEW = transform {
    translate -< c1, c2, c3>
    matrix < INV( r11, r12, r13, r21, r22, r23, r31, r32, r33 ) >
    translate  < o1, o2, o3>
  }

  #macro VEC2PYMOLSPACE(vec)
    #local nvec = vec - PYMOLVIEW_ORGPOS;
    #local nvec =
      < PYMOLVIEW_RMATRIX[0]*nvec.x + PYMOLVIEW_RMATRIX[3]*nvec.y + PYMOLVIEW_RMATRIX[6]*nvec.z,
        PYMOLVIEW_RMATRIX[1]*nvec.x + PYMOLVIEW_RMATRIX[4]*nvec.y + PYMOLVIEW_RMATRIX[7]*nvec.z,
        PYMOLVIEW_RMATRIX[2]*nvec.x + PYMOLVIEW_RMATRIX[5]*nvec.y + PYMOLVIEW_RMATRIX[8]*nvec.z >;
    nvec + PYMOLVIEW_CAMPOS
  #end

  #macro VEC2CARTSPACE(vec)

    #local nvec = vec - PYMOLVIEW_CAMPOS;

    #local R = PYMOLVIEW_RMATRIX;
    #local invdet = 1/DET( R );

    #local T = array[9];

    #local T[0] = invdet * ( R[4]*R[8] - R[5]*R[7] );
    #local T[1] = invdet * ( R[2]*R[7] - R[1]*R[8] );
    #local T[2] = invdet * ( R[1]*R[5] - R[2]*R[4] );
    #local T[3] = invdet * ( R[5]*R[6] - R[3]*R[8] );
    #local T[4] = invdet * ( R[0]*R[8] - R[2]*R[6] );
    #local T[5] = invdet * ( R[2]*R[3] - R[0]*R[5] );
    #local T[6] = invdet * ( R[3]*R[7] - R[4]*R[6] );
    #local T[7] = invdet * ( R[1]*R[6] - R[0]*R[7] );
    #local T[8] = invdet * ( R[0]*R[4] - R[1]*R[3] );

    < T[0]*nvec.x + T[3]*nvec.y + T[6]*nvec.z + PYMOLVIEW_ORGPOS.x,
      T[1]*nvec.x + T[4]*nvec.y + T[7]*nvec.z + PYMOLVIEW_ORGPOS.y,
      T[2]*nvec.x + T[5]*nvec.y + T[8]*nvec.z + PYMOLVIEW_ORGPOS.z >
  #end

  #macro VEC2PYMOLVEC(vec)
    < PYMOLVIEW_RMATRIX[0]*vec.x + PYMOLVIEW_RMATRIX[3]*vec.y + PYMOLVIEW_RMATRIX[6]*vec.z,
      PYMOLVIEW_RMATRIX[1]*vec.x + PYMOLVIEW_RMATRIX[4]*vec.y + PYMOLVIEW_RMATRIX[7]*vec.z,
      PYMOLVIEW_RMATRIX[2]*vec.x + PYMOLVIEW_RMATRIX[5]*vec.y + PYMOLVIEW_RMATRIX[8]*vec.z >
  #end

  #macro VEC2CARTVEC(vec)
    #local nvec = vec - PYMOLVIEW_CAMPOS;
  #end

  #macro CAM2PYMOLCAM()

  #end

  #macro CAM2CARTCAM()

  #end
#end

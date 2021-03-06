#include "pseudopack.h"


MODULE MPI_Data_DisAssemble_v1

  USE Processor
  USE MPI_Communicator_Sub_Group, ONLY: Processor_Active_Status
  USE MPI_Processor_Rank

implicit NONE

INTERFACE PS_MPI_Data_DisAssemble_v1
  MODULE PROCEDURE MPI_Data_DisAssemble_1D
  MODULE PROCEDURE MPI_Data_DisAssemble_2D
  MODULE PROCEDURE MPI_Data_DisAssemble_3D
END INTERFACE

PRIVATE
PUBLIC  :: PS_MPI_Data_DisAssemble_v1

CONTAINS
!
!=======================================================================
!
  Subroutine MPI_Data_DisAssemble_1D (f_g, N0_g, N5_g,   &
                                      f  , N0  , N5  ,   &
                                      n_0, MPI_Comm_Type)

  integer  :: N0_g, N5_g
  integer  :: N0  , N5      
  integer  :: n_0

  integer , OPTIONAL :: MPI_Comm_Type

  REALTYPE, dimension(N0  :N5  )          :: f
  REALTYPE, dimension(N0_g:N5_g), TARGET  :: f_g

#if defined (PARALLEL_MPI)

  REALTYPE, dimension(:)        , POINTER :: p

  integer , dimension(-1:1) :: A 
  integer                   :: MPI_Communicator
  integer                   :: I_Am, First_Processor, Last_Processor
  integer                   :: K_Processor, Tag_1, Tag_2
  integer                   :: Status(MPI_Status_Size)

                              MPI_Communicator = MPI_Comm_World
  if (PRESENT(MPI_Comm_Type)) MPI_Communicator = MPI_Comm_Type

  call PS_MPI_Processor_Rank (I_Am, First_Processor, Last_Processor,  &
                                    MPI_Communicator)

                A(0) = 0
  A(-1) = n_0 ; A(1) = SIZE(f,DIM=1)-1

  f = ZERO 

  if (I_Am == First_Processor) then
    if (Processor_Active_Status) f = f_g(A(-1):A(-1)+A(1))
  endif

  do K_Processor = First_Processor+1,Last_Processor

    call MPI_Barrier (MPI_Communicator, MPI_Error_Status)

    A(0) = 0 ; Tag_1 = K_Processor+5555 ; Tag_2 = K_Processor+6666

    if (I_Am ==     K_Processor) then
      if (Processor_Active_Status) A(0) = 1

      call MPI_Send (A, SIZE(A), MPI_Integer , First_Processor, Tag_1,  &
                                 MPI_Communicator,         MPI_Error_Status)
    endif

    if (I_Am == First_Processor) then
      call MPI_Recv (A, SIZE(A), MPI_Integer ,     K_Processor, Tag_1,  &
                                 MPI_Communicator, Status, MPI_Error_Status)
    endif

    if (A(0) == 0) CYCLE

    if (I_Am == First_Processor) then
      Nullify (p) ; p => f_g(A(-1):A(-1)+A(1))
    endif

    call MPI_Barrier (MPI_Communicator, MPI_Error_Status)

    if (I_Am == First_Processor)   &
      call MPI_Send (p, SIZE(p), MPI_REALTYPE,     K_Processor, Tag_2,  &
                                 MPI_Communicator,         MPI_Error_Status)

    if (I_Am ==     K_Processor)   &
      call MPI_Recv (f, SIZE(f), MPI_REALTYPE, First_Processor, Tag_2,  &
                                 MPI_Communicator, Status, MPI_Error_Status)
  enddo

  call MPI_Barrier (MPI_Communicator, MPI_Error_Status)

#else

  f = f_g

#endif

  END Subroutine MPI_Data_DisAssemble_1D
!
!=======================================================================
!
  Subroutine MPI_Data_DisAssemble_2D (f_g, N0_g, N5_g, M0_g, M5_g,  &
                                      f  , N0  , N5  , M0  , M5  ,  &
                                      n_0, m_0, MPI_Comm_Type)

  integer  :: N0_g, N5_g, M0_g, M5_g
  integer  :: N0  , N5  , M0  , M5    
  integer  :: n_0, m_0

  integer , OPTIONAL :: MPI_Comm_Type

  REALTYPE, dimension(N0  :N5  ,M0  :M5  )          :: f
  REALTYPE, dimension(N0_g:N5_g,M0_g:M5_g), TARGET  :: f_g

#if defined (PARALLEL_MPI)

  REALTYPE, dimension(:,:)                , POINTER :: p

  integer , dimension(-2:2) :: A 
  integer                   :: MPI_Communicator
  integer                   :: I_Am, First_Processor, Last_Processor
  integer                   :: K_Processor, Tag_1, Tag_2
  integer                   :: Status(MPI_Status_Size)

                              MPI_Communicator = MPI_Comm_World
  if (PRESENT(MPI_Comm_Type)) MPI_Communicator = MPI_Comm_Type

  call PS_MPI_Processor_Rank (I_Am, First_Processor, Last_Processor,  &
                                    MPI_Communicator)

                A(0) = 0
  A(-1) = n_0 ; A(1) = SIZE(f,DIM=1)-1
  A(-2) = m_0 ; A(2) = SIZE(f,DIM=2)-1

  f = ZERO 

  if (I_Am == First_Processor) then
    if (Processor_Active_Status) f = f_g(A(-1):A(-1)+A(1),A(-2):A(-2)+A(2)) 
  endif

  do K_Processor = First_Processor+1,Last_Processor

    call MPI_Barrier (MPI_Communicator, MPI_Error_Status)

    A(0) = 0 ; Tag_1 = K_Processor+5555 ; Tag_2 = K_Processor+6666

    if (I_Am ==     K_Processor) then
      if (Processor_Active_Status) A(0) = 1

      call MPI_Send (A, SIZE(A), MPI_Integer , First_Processor, Tag_1,  &
                                 MPI_Communicator,         MPI_Error_Status)
    endif

    if (I_Am == First_Processor) then
      call MPI_Recv (A, SIZE(A), MPI_Integer ,     K_Processor, Tag_1,  &
                                 MPI_Communicator, Status, MPI_Error_Status)
    endif

    if (A(0) == 0) CYCLE

    if (I_Am == First_Processor) then
      Nullify (p) ; p => f_g(A(-1):A(-1)+A(1),A(-2):A(-2)+A(2))
    endif

    call MPI_Barrier (MPI_Communicator, MPI_Error_Status)

    if (I_Am == First_Processor)   &
      call MPI_Send (p, SIZE(p), MPI_REALTYPE,     K_Processor, Tag_2,  &
                                 MPI_Communicator,         MPI_Error_Status)

    if (I_Am ==     K_Processor)   &
      call MPI_Recv (f, SIZE(f), MPI_REALTYPE, First_Processor, Tag_2,  &
                                 MPI_Communicator, Status, MPI_Error_Status)
  enddo

  call MPI_Barrier (MPI_Communicator, MPI_Error_Status)

#else

  f = f_g

#endif

  END Subroutine MPI_Data_DisAssemble_2D
!
!=======================================================================
!
  Subroutine MPI_Data_DisAssemble_3D (f_g, N0_g, N5_g, M0_g, M5_g, K0_g, K5_g, &
                                      f  , N0  , N5  , M0  , M5  , K0  , K5  , &
                                      n_0, m_0, k_0, MPI_Comm_Type)

  integer  :: N0_g, N5_g, M0_g, M5_g, K0_g, K5_g
  integer  :: N0  , N5  , M0  , M5  , K0  , K5  
  integer  :: n_0, m_0, k_0

  integer , OPTIONAL :: MPI_Comm_Type

  REALTYPE, dimension(N0  :N5  ,M0  :M5  ,K0  :K5  )          :: f
  REALTYPE, dimension(N0_g:N5_g,M0_g:M5_g,K0_g:K5_g), TARGET  :: f_g

#if defined (PARALLEL_MPI)

  REALTYPE, dimension(:,:,:)                        , POINTER :: p

  integer , dimension(-3:3) :: A 
  integer                   :: MPI_Communicator
  integer                   :: I_Am, First_Processor, Last_Processor
  integer                   :: K_Processor, Tag_1, Tag_2
  integer                   :: Status(MPI_Status_Size)

                              MPI_Communicator = MPI_Comm_World
  if (PRESENT(MPI_Comm_Type)) MPI_Communicator = MPI_Comm_Type

  call PS_MPI_Processor_Rank (I_Am, First_Processor, Last_Processor,  &
                                    MPI_Communicator)

                A(0) = 0
  A(-1) = n_0 ; A(1) = SIZE(f,DIM=1)-1
  A(-2) = m_0 ; A(2) = SIZE(f,DIM=2)-1
  A(-3) = k_0 ; A(3) = SIZE(f,DIM=3)-1

  f = ZERO 

  if (I_Am == First_Processor) then
    if (Processor_Active_Status) &
      f = f_g(A(-1):A(-1)+A(1),A(-2):A(-2)+A(2),A(-3):A(-3)+A(3))
  endif

  do K_Processor = First_Processor+1,Last_Processor

    call MPI_Barrier (MPI_Communicator, MPI_Error_Status)

    A(0) = 0 ; Tag_1 = K_Processor+5555 ; Tag_2 = K_Processor+6666

    if (I_Am ==     K_Processor) then
      if (Processor_Active_Status) A(0) = 1

      call MPI_Send (A, SIZE(A), MPI_Integer , First_Processor, Tag_1,  &
                                 MPI_Communicator,         MPI_Error_Status)
    endif

    if (I_Am == First_Processor) then
      call MPI_Recv (A, SIZE(A), MPI_Integer ,     K_Processor, Tag_1,  &
                                 MPI_Communicator, Status, MPI_Error_Status)
    endif

    if (A(0) == 0) CYCLE

    if (I_Am == First_Processor) then
      Nullify (p) ; p => f_g(A(-1):A(-1)+A(1),A(-2):A(-2)+A(2),A(-3):A(-3)+A(3))
    endif

    call MPI_Barrier (MPI_Communicator, MPI_Error_Status)

    if (I_Am == First_Processor)   &
      call MPI_Send (p, SIZE(p), MPI_REALTYPE,     K_Processor, Tag_2,  &
                                 MPI_Communicator,         MPI_Error_Status)

    if (I_Am ==     K_Processor)   &
      call MPI_Recv (f, SIZE(f), MPI_REALTYPE, First_Processor, Tag_2,  &
                                 MPI_Communicator, Status, MPI_Error_Status)
  enddo

  call MPI_Barrier (MPI_Communicator, MPI_Error_Status)

#else

  f = f_g

#endif

  END Subroutine MPI_Data_DisAssemble_3D

END MODULE MPI_Data_DisAssemble_v1

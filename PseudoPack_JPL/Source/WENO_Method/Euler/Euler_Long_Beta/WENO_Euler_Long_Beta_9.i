          V(0) = C(0,0)*F(i,-4,l) + C(0,1)*F(i,-3,l) + C(0,2)*F(i,-2,l) + &
                 C(0,3)*F(i,-1,l) + C(0,4)*F(i, 0,l) 
          V(1) = C(1,0)*F(i,-3,l) + C(1,1)*F(i,-2,l) + C(1,2)*F(i,-1,l) + &
                 C(1,3)*F(i, 0,l) + C(1,4)*F(i, 1,l) 
          V(2) = C(2,0)*F(i,-2,l) + C(2,1)*F(i,-1,l) + C(2,2)*F(i, 0,l) + &
                 C(2,3)*F(i, 1,l) + C(2,4)*F(i, 2,l) 
          V(3) = C(3,0)*F(i,-1,l) + C(3,1)*F(i, 0,l) + C(3,2)*F(i, 1,l) + &
                 C(3,3)*F(i, 2,l) + C(3,4)*F(i, 3,l) 
          V(4) = C(4,0)*F(i, 0,l) + C(4,1)*F(i, 1,l) + C(4,2)*F(i, 2,l) + &
                 C(4,3)*F(i, 3,l) + C(4,4)*F(i, 4,l) 

          b(0) = F(i,-4,l)*(S(0,0,0)*F(i,-4,l) + S(0,1,0)*F(i,-3,l) + &
                            S(0,2,0)*F(i,-2,l) + S(0,3,0)*F(i,-1,l) + &
                            S(0,4,0)*F(i, 0,l)                        ) + &
                 F(i,-3,l)*(S(1,1,0)*F(i,-3,l) + S(1,2,0)*F(i,-2,l) + &
                            S(1,3,0)*F(i,-1,l) + S(1,4,0)*F(i, 0,l)   ) + &
                 F(i,-2,l)*(S(2,2,0)*F(i,-2,l) + S(2,3,0)*F(i,-1,l) + &
                            S(2,4,0)*F(i, 0,l)                        ) + &
                 F(i,-1,l)*(S(3,3,0)*F(i,-1,l) + S(3,4,0)*F(i, 0,l)   ) + &
                 F(i, 0,l)*(S(4,4,0)*F(i, 0,l)                        ) 

          b(1) = F(i,-3,l)*(S(0,0,1)*F(i,-3,l) + S(0,1,1)*F(i,-2,l) + &
                            S(0,2,1)*F(i,-1,l) + S(0,3,1)*F(i, 0,l) + &
                            S(0,4,1)*F(i, 1,l)                        ) + &
                 F(i,-2,l)*(S(1,1,1)*F(i,-2,l) + S(1,2,1)*F(i,-1,l) + &
                            S(1,3,1)*F(i, 0,l) + S(1,4,1)*F(i, 1,l)   ) + &
                 F(i,-1,l)*(S(2,2,1)*F(i,-1,l) + S(2,3,1)*F(i, 0,l) + &
                            S(2,4,1)*F(i, 1,l)                        ) + &
                 F(i, 0,l)*(S(3,3,1)*F(i, 0,l) + S(3,4,1)*F(i, 1,l)   ) + &
                 F(i, 1,l)*(S(4,4,1)*F(i, 1,l)                        ) 

          b(2) = F(i,-2,l)*(S(0,0,2)*F(i,-2,l) + S(0,1,2)*F(i,-1,l) + &
                            S(0,2,2)*F(i, 0,l) + S(0,3,2)*F(i, 1,l) + &
                            S(0,4,2)*F(i, 2,l)                        ) + &
                 F(i,-1,l)*(S(1,1,2)*F(i,-1,l) + S(1,2,2)*F(i, 0,l) + &
                            S(1,3,2)*F(i, 1,l) + S(1,4,2)*F(i, 2,l)   ) + &
                 F(i, 0,l)*(S(2,2,2)*F(i, 0,l) + S(2,3,2)*F(i, 1,l) + &
                            S(2,4,2)*F(i, 2,l)                        ) + &
                 F(i, 1,l)*(S(3,3,2)*F(i, 1,l) + S(3,4,2)*F(i, 2,l)   ) + &
                 F(i, 2,l)*(S(4,4,2)*F(i, 2,l)                        ) 

          b(3) = F(i,-1,l)*(S(0,0,3)*F(i,-1,l) + S(0,1,3)*F(i, 0,l) + &
                            S(0,2,3)*F(i, 1,l) + S(0,3,3)*F(i, 2,l) + &
                            S(0,4,3)*F(i, 3,l)                        ) + &
                 F(i, 0,l)*(S(1,1,3)*F(i, 0,l) + S(1,2,3)*F(i, 1,l) + &
                            S(1,3,3)*F(i, 2,l) + S(1,4,3)*F(i, 3,l)   ) + &
                 F(i, 1,l)*(S(2,2,3)*F(i, 1,l) + S(2,3,3)*F(i, 2,l) + &
                            S(2,4,3)*F(i, 3,l)                        ) + &
                 F(i, 2,l)*(S(3,3,3)*F(i, 2,l) + S(3,4,3)*F(i, 3,l)   ) + &
                 F(i, 3,l)*(S(4,4,3)*F(i, 3,l)                        ) 

          b(4) = F(i, 0,l)*(S(0,0,4)*F(i, 0,l) + S(0,1,4)*F(i, 1,l) + &
                            S(0,2,4)*F(i, 2,l) + S(0,3,4)*F(i, 3,l) + &
                            S(0,4,4)*F(i, 4,l)                        ) + &
                 F(i, 1,l)*(S(1,1,4)*F(i, 1,l) + S(1,2,4)*F(i, 2,l) + &
                            S(1,3,4)*F(i, 3,l) + S(1,4,4)*F(i, 4,l)   ) + &
                 F(i, 2,l)*(S(2,2,4)*F(i, 2,l) + S(2,3,4)*F(i, 3,l) + &
                            S(2,4,4)*F(i, 4,l)                        ) + &
                 F(i, 3,l)*(S(3,3,4)*F(i, 3,l) + S(3,4,4)*F(i, 4,l)   ) + &
                 F(i, 4,l)*(S(4,4,4)*F(i, 4,l)                        ) 

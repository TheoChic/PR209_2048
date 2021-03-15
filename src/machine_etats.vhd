library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL ;


entity machine_etats is
  Port (   CLK, RST, CE	                               : IN STD_LOGIC;
	       
	       btn_haut, btn_bas, btn_droit, btn_gauche    : IN STD_LOGIC;
	       
	       index_grille                                : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	       cpt_init                                    : OUT STD_LOGIC;	              
           
           value                                       : OUT STD_LOGIC_VECTOR(255 DOWNTO 0));
           -- index : 4 bits de poids fort : index grille iijj
           -- puissance :  12 bits de poids faible : valeur de la puissance de 2
           -- grille de 16 cases : 16 vecteurs de taille 11 DONWTO 0 -> 192
           
           TYPE Etat is (Init, Ajout_nombre, Export_grille, Waiting, Decalage, Calcul);
           SIGNAL pr_state, nx_state : Etat := Init;
           
end machine_etats;

architecture beh_machine_etats of machine_etats is

SIGNAL val_btn      : STD_LOGIC_VECTOR(1 DOWNTO 0);
signal cal_next     : std_logic;

SIGNAL grille       : STD_LOGIC_VECTOR(191 DOWNTO 0);

-- indexes des colonnes i et des lignes j de la grille 
SIGNAL index_i      : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL index_j      : STD_LOGIC_VECTOR(1 DOWNTO 0);

SIGNAL add          : integer;
                                                    
begin
    index_j <= index_grille(3 DOWNTO 2);
    index_i <= index_grille(1 DOWNTO 0);

maj_etat : PROCESS ( CLK , RST )
    BEGIN
        IF ( RST = '1') THEN
            pr_state <= Init ;
        ELSIF ( CLK'EVENT AND CLK = '1' AND CE = '1') THEN
            pr_state <= nx_state ;
        END IF;     
END PROCESS maj_etat;

cal_nx_state : PROCESS (RST, pr_state)
    BEGIN
    
        CASE pr_state IS
        
            WHEN Init =>    
                cpt_init <= '1';
                IF (RST = '0') THEN
                    grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= "000000000000";
                    
                    if(to_integer(unsigned(index_i)) = 3 and to_integer(unsigned(index_i)) = 3) then
                        nx_state <= Ajout_nombre;
                    end if;
                    ELSE
                        nx_state <= Init;
                    END IF;

            WHEN Ajout_nombre =>
                cpt_init <= '1';
                
                if(grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) = "000000000000") then
                    grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= "000000000010";  
                    nx_state <= Export_grille;
                end if;
              
            WHEN Export_grille => 
                cpt_init <= '1';
                value(255 - 16 * to_integer(unsigned(index_i)) - 4 * 16 * to_integer(unsigned(index_j)) DOWNTO 255 - 16 * to_integer(unsigned(index_i)) - 4 * 16 * to_integer(unsigned(index_j)) - 1 ) <= index_j;
                value(255 - 16 * to_integer(unsigned(index_i)) - 4 * 16 * to_integer(unsigned(index_j)) - 2 DOWNTO 255 - 16 * to_integer(unsigned(index_i)) - 4 * 16 * to_integer(unsigned(index_j)) - 3 ) <= index_i;
                value(255 - 16 * to_integer(unsigned(index_i)) - 4 * 16 * to_integer(unsigned(index_j)) - 4 DOWNTO 255 - 16 * to_integer(unsigned(index_i)) - 4 * 16 * to_integer(unsigned(index_j)) - 11 - 4 ) <= grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 );
                
                if(to_integer(unsigned(index_i)) = 3 and to_integer(unsigned(index_j)) = 3) then
                    nx_state <= Waiting;
                end if;
            
            WHEN Waiting =>
                
                cal_next <= '0';
                
                if (btn_haut = '1') then 
                    val_btn <= "00";
                    cal_next <= '1';
                    
                elsif (btn_droit = '1') then 
                    val_btn <= "01";
                    cal_next <= '1';
                    
                elsif (btn_bas = '1') then 
                    val_btn <= "10";
                    cal_next <= '1';
                    
                elsif (btn_gauche = '1') then 
                    val_btn <= "11";
                    cal_next <= '1';
                end if;
                
                if(cal_next = '1') then
                    cal_next <= '0';
                    nx_state <= Decalage;
                end if;
           
            WHEN Decalage =>
                
                cpt_init <= '1';         
                
                case val_btn IS
                    when "00" => -- incrémentation i, incrémentation j
                        if(grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) = "000000000000") then
                            if(to_integer(unsigned(index_j)) < 3) then
                                grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j) + 1) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j) + 1) - 11 );
                                grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j) + 1) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j) + 1) - 11 ) <= "000000000000";
                            end if;
                        end if;

                    when "01" => -- décrémentation i, décrémentation j
                        if(grille(191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) DOWNTO 191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) - 11 ) = "000000000000") then
                            if(to_integer(3 - unsigned(index_i)) > 0) then
                                grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= grille(191 - 12 * to_integer(unsigned(index_i) - 1) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i) - 1) - 4 * 12 * to_integer(unsigned(index_j)) - 11 );
                                grille(191 - 12 * to_integer(unsigned(index_i) - 1) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i) - 1) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= "000000000000";
                            end if;
                        end if;
       
                    when "10" => -- décrémentation i, décrémentation j
                        if(grille(191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) DOWNTO 191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) - 11 ) = "000000000000") then
                            if(to_integer(3 - unsigned(index_j)) > 0) then
                                grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j) - 1) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j) - 1) - 11 );
                                grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j) - 1) DOWNTO 191 - 12 * to_integer(unsigned(index_i) - 1) - 4 * 12 * to_integer(unsigned(index_j) - 1) - 11 ) <= "000000000000";
                            end if;
                        end if;
                            
                    when "11" => -- incrémentation i, incrémentation j
                        if(grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) = "000000000000") then
                            if(to_integer(unsigned(index_j)) < 3) then
                                grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= grille(191 - 12 * to_integer(unsigned(index_i) + 1) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i) + 1) - 4 * 12 * to_integer(unsigned(index_j)) - 11 );
                                grille(191 - 12 * to_integer(unsigned(index_i) + 1) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i) + 1) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= "000000000000"; 
                            end if;
                        end if;
                    
                    when others => -- do nothing
                                                                            
                end case;
                
                if(to_integer(unsigned(index_i)) = 3 and to_integer(unsigned(index_j)) = 3) then
                    nx_state <= Calcul;
                end if;
                
            when Calcul =>  
            
                cpt_init <= '1';

                    case val_btn IS
                        when "00" =>
                            if(grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) = "000000000000") then
                                if(to_integer(unsigned(index_j)) < 3) then
                                    add <= to_integer(2 * unsigned(grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 )));
                                    grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= std_logic_vector(to_unsigned(add, 12));
                                    grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j) + 1) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j) + 1) - 11 ) <= "000000000000";
                                end if;
                            end if;

                        when "01" =>
                            if(grille(191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) DOWNTO 191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) - 11 ) = "000000000000") then
                                if(to_integer(3 - unsigned(index_i)) > 0) then
                                    add <= to_integer(2 * unsigned(grille(191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) DOWNTO 191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) - 11 )));
                                    grille(191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) DOWNTO 191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) - 11 ) <= std_logic_vector(to_unsigned(add, 12));
                                    grille(191 - 12 * to_integer(3 - unsigned(index_i) - 1) - 4 * 12 * to_integer(3 - unsigned(index_j)) DOWNTO 191 - 12 * to_integer(3 - unsigned(index_i) + 1) - 4 * 12 * to_integer(3 - unsigned(index_j)) - 11 ) <= "000000000000";
                                end if;
                            end if;
       
                        when "10" =>
                            if(grille(191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) DOWNTO 191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) - 11 ) = "000000000000") then
                                if(to_integer(3 - unsigned(index_j)) > 0) then
                                    add <= to_integer(2 * unsigned(grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 )));
                                    grille(191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) DOWNTO 191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j)) - 11 ) <= std_logic_vector(to_unsigned(add, 12));
                                    grille(191 - 12 * to_integer(3 - unsigned(index_i)) - 4 * 12 * to_integer(3 - unsigned(index_j) + 1) DOWNTO 191 - 12 * to_integer(3 - unsigned(index_i) + 1) - 4 * 12 * to_integer(3 - unsigned(index_j) - 1) - 11 ) <= "000000000000";
                                end if;
                            end if;

                            when "11" =>
                                if(grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) = "000000000000") then
                                if(to_integer(unsigned(index_j)) < 3) then
                                    add <= to_integer(2 * unsigned(grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 )));
                                    grille(191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i)) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= std_logic_vector(to_unsigned(add, 12));
                                    grille(191 - 12 * to_integer(unsigned(index_i) + 1) - 4 * 12 * to_integer(unsigned(index_j)) DOWNTO 191 - 12 * to_integer(unsigned(index_i) + 1) - 4 * 12 * to_integer(unsigned(index_j)) - 11 ) <= "000000000000"; 
                                end if;
                            end if;
                         
                         when others => -- do nothing
                                                                            
                    end case;
                
                if(to_integer(unsigned(index_i)) = 3 and to_integer(unsigned(index_i)) = 3) then
                    if(cal_next = '0') then
                        cal_next <= '1';
                        nx_state <= Decalage;
                    else 
                        nx_state <= Ajout_nombre;
                    end if;
                end if;            
                                           
            end case;
        
END PROCESS cal_nx_state;

end beh_machine_etats;

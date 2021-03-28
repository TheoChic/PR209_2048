library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL ;


entity machine_etats is
  Port (    CLK, RST, CE            : in STD_LOGIC;
                       
            ind_i, ind_j            : in STD_LOGIC_VECTOR (1 downto 0);       
            cmp, zero               : in std_logic;
            
            btn                     : in STD_LOGIC;
          
            cpt_ram_grille_en, cpt_ram_grille_init        : out STD_LOGIC;
            addr_max_ram_grille     : in STD_LOGIC;
            
            cpt_ram_ext_en, cpt_ram_ext_init        : out STD_LOGIC;
            addr_max_ram_ext        : in STD_LOGIC;
            
            w_en_ram_grille         : out STD_LOGIC;
            w_en_ram_ext            : out STD_LOGIC;

            sel_addr, sel_addw      : out STD_LOGIC;
            sel_dataw               : out STD_LOGIC_VECTOR(1 downto 0));
end machine_etats;

architecture beh_machine_etats of machine_etats is

type Etat is (INIT, AJOUT_NOMBRE, EXPORT_GRILLE, WAITING, RECHERCHE_ZERO, DECALAGE, AJOUT_ZERO, SAVING, CALCUL);
signal pr_state, nx_state : Etat := Init;

signal cpt : integer range 1 to 5 := 0; 
signal enable_cpt_intern : STD_LOGIC;

signal bool_calc : boolean := FALSE;
signal previous_state : Etat := INIT;
                                               
begin
    cpt_case : process( clk, rst)
        begin
            if ( rst = '0') then
                cpt <= 0 ;
            elsif ( clk'event and clk = '1' and CE = '1' and enable_cpt_intern = '1') then
                cpt <= cpt + 1 ;
            end if;   
    end process cpt_case;
     
    maj_etat : process ( clk , rst ) --mise à jour des états
        begin
            if ( rst = '0') then
                pr_state <= Init ;
            elsif ( clk'event and clk = '1' and CE = '1') then
                pr_state <= nx_state ;
            end if;     
    end process maj_etat;

    cal_sig : process (rst, pr_state) --process transition
        begin
        
            case pr_state is
            
                when INIT =>    
                    
                when AJOUT_NOMBRE =>
                    -- on balance la grille de 0
                    cpt_ram_ext_init    <= '1';

                when EXPORT_GRILLE => 
                    w_en_ram_ext        <= '1';
                    cpt_ram_ext_en      <= '1';
                    
                    cpt_ram_ext_init    <= '0';
                    cpt_ram_grille_en   <= '0';
                    cpt_ram_grille_init <= '0';
                    enable_cpt_intern   <= '0';
                    w_en_ram_grille <= '0';
                    sel_dataw       <= "00";
                    sel_addr        <= '0'; 
                    sel_addw            <= '0';
    

                    --activer un compteur qui ballaye toutes les cases, on reste dans l'état tant que pas addr max
                    --activer l'écriture sur la ram CPU qui fonctionnera en front descendant
                    --correctement orienter les mux    
                when WAITING =>
                    w_en_ram_ext        <= '0';
                    cpt_ram_ext_en      <= '0';
                    cpt_ram_ext_init    <= '1';
                    sel_addw            <= '0';
                    cpt_ram_grille_en   <= '0';
                    cpt_ram_grille_init <= '1';
                    enable_cpt_intern   <= '0';
                    w_en_ram_grille <= '0';
                    sel_dataw       <= "00";
                    sel_addr        <= '0';  
                    
                    cpt <= 0;
                when RECHERCHE_ZERO =>
                    if cpt < 4 then 
                        if zero = '1' then
                            cpt_ram_grille_en   <= '0';
                            enable_cpt_intern   <= '0';
                        else
                            cpt_ram_grille_en   <= '1';
                            enable_cpt_intern   <= '1';
                        end if;
                    else
                        cpt_ram_grille_en   <= '1';
                        enable_cpt_intern   <= '0';
                        cpt <= 1;
                    end if;
                    
                    if addr_max_ram_grille = '1' then
                        cpt_ram_grille_init  <= '1';
                    end if;
                    
                when DECALAGE =>
                    w_en_ram_grille <= '1';
                    sel_dataw       <= "01";
                    sel_addr        <= '1';
                    
                    sel_addw            <= '0';
                    cpt_ram_grille_en   <= '0';
                    enable_cpt_intern   <= '0';
                    cpt_ram_grille_init <= '0';
                    previous_state      <= DECALAGE;
                    
                when AJOUT_ZERO =>
                    w_en_ram_grille    <= '1';
                    sel_dataw          <= "00";
                    
                    sel_addr            <= '0';
                    sel_addw            <= '0';
                    cpt_ram_grille_en   <= '1'; --FAIRE ATTENTION A CE QUE CE SOIT ACTIF SUR LE FRONT D'APRES : si je l'active maintenant, c'est pour qu'au coup d'H suivant on puisse incrémenter
                    enable_cpt_intern   <= '1';
                    
                when SAVING =>
                    cpt_ram_grille_en   <= '1'; 
                    enable_cpt_intern   <= '0';
                    cpt                 <= 2;    
                                    
                    w_en_ram_grille     <= '0';
                    sel_dataw       <= "00";
                    sel_addr        <= '0';
                    sel_addw        <= '0';
                    cpt_ram_grille_init   <= '0';     
                               
                when CALCUL =>  
                    bool_calc <= TRUE;
                    
                    if cmp = '1' then
                        w_en_ram_grille            <= '1';
                    else
                        w_en_ram_grille            <= '0';
                    end if;   
                    
                    if addr_max_ram_grille = '1' then
                        cpt_ram_grille_init  <= '1';
                    end if;
                
                    sel_dataw           <= "10";
                    sel_addw            <= '0';
                    cpt_ram_grille_en   <= '1'; 
                    enable_cpt_intern   <= '1';
                                    
                    sel_addr             <= '0';
                    cpt_ram_grille_init  <= '0';        
                    previous_state <= CALCUL;
                end case;
            
    end process cal_sig;

    cal_nx_state : process (rst, pr_state) --process signaux
        begin
        
            case pr_state is
            
                when INIT =>    
                    -- on balance la grille de 0
                when AJOUT_NOMBRE =>
                    --pas de random, cpt qui balmlait les case et met un 0 qq part    
                when EXPORT_GRILLE => 
                    --activer un compteur qui ballaye toutes les cases, on reste dans l'état tant que pas addr max
                    --activer l'écriture sur la ram CPU qui fonctionnera en front descendant
                    --correctement orienter les mux 
                when WAITING =>
                    --tant que pas de bouton, on reste
                when RECHERCHE_ZERO =>
                    if addr_max_ram_grille = '1' and bool_calc = FALSE then
                        nx_state <= SAVING;
                        
                    elsif addr_max_ram_grille = '1' and bool_calc = TRUE then
                        nx_state <= AJOUT_NOMBRE;
                        
                    elsif zero = '1' then
                        nx_state <= DECALAGE;
                    
                    else
                        nx_state <= RECHERCHE_ZERO;
                    end if;
                    
                when DECALAGE =>
                    nx_state <= AJOUT_ZERO;
                    
                when AJOUT_ZERO =>
                    if previous_state = DECALAGE then
                        nx_state <= RECHERCHE_ZERO;
                    elsif previous_state = CALCUL then
                        nx_state <= CALCUL;
                    else 
                        nx_state <= AJOUT_ZERO;
                    end if;
                        
                when SAVING =>
                    nx_state <= CALCUL;
                    
                when CALCUL =>  
                    if addr_max_ram_grille = '1' then
                        nx_state <= RECHERCHE_ZERO;
                        
                    elsif cpt <= 4 then
                        nx_state <= SAVING;
                        
                    elsif cmp = '1' then
                        nx_state <= AJOUT_ZERO;
                    
                    else
                        nx_state <= CALCUL;
                    end if;
                    
                end case;
            
    end process cal_nx_state;

end beh_machine_etats;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL ;

-- TODO : CHECK EN FIN De cycle, quand on reste dans recherche 0 même après un addr max, avant le sig on doit faire un décalage, et après on doit aller dans ajour nombre : TB 96us
entity machine_etats is
  Port (    CLK, RST, CE            : in STD_LOGIC;
            
            cmp, zero               : in std_logic;
            
            btn_haut                : in STD_LOGIC;
            btn_bas                 : in STD_LOGIC;
            btn_gauche              : in STD_LOGIC;
            btn_droit               : in STD_LOGIC;

            init_btn                : out STD_LOGIC;
          
            cpt_ram_grille_en, cpt_ram_grille_init        : out STD_LOGIC;
            addr_max_ram_grille     : in STD_LOGIC;
            
            cpt_ram_ext_en, cpt_ram_ext_init        : out STD_LOGIC;
            addr_max_ram_ext        : in STD_LOGIC;
            
            w_en_ram_grille         : out STD_LOGIC;
            w_en_ram_ext            : out STD_LOGIC;

            sel_addr, sel_addw      : out STD_LOGIC;
            sel_dataw               : out STD_LOGIC_VECTOR(1 downto 0);
            val_btn_init            : out STD_LOGIC);
end machine_etats;

architecture beh_machine_etats of machine_etats is

type Etat is (INIT,INIT_GRILLE, AJOUT_NOMBRE, RESET_ADDR_GRILLE, EXPORT_GRILLE, WAITING, RECHERCHE_ZERO, DECALAGE, AJOUT_ZERO, SAVING, CALCUL, ADD);
signal pr_state, nx_state : Etat := Init;

signal cpt : integer range 1 to 5 := 1; 
signal init_intern_cpt_1, init_intern_cpt_2 : STD_LOGIC;
signal enable_cpt_intern : STD_LOGIC;

signal bool_calc, bool_ajout_nombre  : boolean := FALSE;
signal previous_state : Etat := INIT;
                                               
begin
    cpt_case : process( clk, rst)
        begin
            if ( rst = '0') then
                cpt <= 1 ;
            elsif ( clk'event and clk = '1' and CE = '1') then
                if(init_intern_cpt_1 = '1') then 
                    cpt <= 1;
                elsif (init_intern_cpt_2 = '1') then
                    cpt <= 2;
                elsif enable_cpt_intern = '1' then 
                    cpt <= cpt + 1; 
                end if;
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

    cal_sig : process (pr_state, addr_max_ram_grille, bool_calc, zero, previous_state, cpt, cmp) --process action
        begin
        
            case pr_state is
            
                when INIT => 
                    -- on balance la grille de 0
                    sel_dataw           <= "00";
                    sel_addw            <= '0';
                    cpt_ram_grille_en   <= '0';
                    w_en_ram_grille     <= '0';

                    enable_cpt_intern   <= '0';
                    sel_addr            <= '0'; 
                    w_en_ram_ext        <= '0';
                    cpt_ram_ext_en      <= '0';
                    cpt_ram_ext_init    <= '1';
                    cpt_ram_grille_init  <= '1';

                    init_btn <= '0';
                    
                    init_intern_cpt_1 <= '0';
                    init_intern_cpt_2 <= '0';
                    
                    previous_state <= INIT;
                    bool_ajout_nombre <= TRUE;
                    val_btn_init <= '0';
                    
                when INIT_GRILLE => 
                    -- on balance la grille de 0
                    sel_dataw           <= "00";
                    sel_addw            <= '0';
                    cpt_ram_grille_en   <= '1';
                    w_en_ram_grille     <= '1';
                  
                    cpt_ram_grille_init <= '0';
                   
                    
                    enable_cpt_intern   <= '0';
                    sel_addr            <= '0'; 
                    w_en_ram_ext        <= '0';
                    cpt_ram_ext_en      <= '0';
                    cpt_ram_ext_init    <= '0';
                    cpt_ram_grille_init  <= '0';

                    init_btn <= '0';
                    
                    init_intern_cpt_1 <= '0';
                    init_intern_cpt_2 <= '0';
                    val_btn_init <= '1';

                when RESET_ADDR_GRILLE =>
                    sel_dataw           <= "00";
                    sel_addw            <= '0';
                    cpt_ram_grille_en   <= '0';
                    w_en_ram_grille     <= '0';

                    enable_cpt_intern   <= '0';
                    sel_addr            <= '0'; 
                    w_en_ram_ext        <= '0';
                    cpt_ram_ext_en      <= '0';
                    cpt_ram_ext_init    <= '0';
                    cpt_ram_grille_init  <= '1';

                    init_btn <= '0';
                    
                    init_intern_cpt_1 <= '1';
                    init_intern_cpt_2 <= '0';
                    
                    previous_state <= RESET_ADDR_GRILLE;
                    
                    cpt_ram_grille_init <= '1';
                    val_btn_init <= '0';

                when AJOUT_NOMBRE =>
                    -- on balance la grille de 0
                    
                    sel_dataw           <= "11";
                    sel_addw            <= '0';
                    w_en_ram_grille     <= '1';
                    
                    cpt_ram_grille_en   <= '0';
                    cpt_ram_grille_init <= '0';                  
                    enable_cpt_intern   <= '0';
                    sel_addr            <= '0'; 
                    w_en_ram_ext        <= '0';
                    cpt_ram_ext_en      <= '0';
                    cpt_ram_ext_init    <= '0';
                    init_btn <= '0';
                    init_intern_cpt_1 <= '0';
                    init_intern_cpt_2 <= '0';
                    
                    bool_ajout_nombre <= FALSE;

                    
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
    
                    init_btn <= '1';
                    init_intern_cpt_1 <= '0';
                    init_intern_cpt_2 <= '0';
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
                    init_btn <= '0';
                    
                    bool_calc <= FALSE;
                    init_intern_cpt_1 <= '1';
                    init_intern_cpt_2 <= '0';
                    previous_state <= WAITING;
                    
                when RECHERCHE_ZERO =>
                    if cpt > 3 then  --Le CPT interne permet d'ignorer la dernière valeur d'une ligne
                        init_intern_cpt_1   <= '1';
                    else
                        init_intern_cpt_1   <= '0';
                    end if;
                    
                    cpt_ram_grille_en   <= '1';
                    enable_cpt_intern   <= '1';
                    
                    if addr_max_ram_grille = '1' and bool_calc = TRUE then
                        bool_ajout_nombre <= TRUE; 
                    end if;       
                          
                    sel_addr            <= '0';  

                    init_intern_cpt_2 <= '0';
                    w_en_ram_ext        <= '0';
                    cpt_ram_ext_en      <= '0';
                    cpt_ram_ext_init    <= '0';
                    cpt_ram_grille_init    <= '0';

                    sel_addw            <= '0';
                    w_en_ram_grille     <= '0';
                    sel_dataw           <= "00";
                    init_btn <= '0';
                    
                when DECALAGE =>
                    w_en_ram_grille <= '1';
                    sel_dataw       <= "01";
                    sel_addw        <= '1';
                    sel_addr        <= '0';
                    
                 
                    
                    cpt_ram_grille_en   <= '0';
                    enable_cpt_intern   <= '0';
                    cpt_ram_grille_init <= '0';
                    previous_state      <= DECALAGE;
                    init_btn <= '0';
                    
                    init_intern_cpt_1   <= '0';
                    init_intern_cpt_2   <= '0';
                    
                when AJOUT_ZERO =>
                    w_en_ram_grille    <= '1';
                    sel_dataw          <= "00";
                    
                    sel_addr            <= '0';
                    sel_addw            <= '0';
                    
                    
                    cpt_ram_grille_en   <= '0'; --FAIRE ATTENTION A CE QUE CE SOIT ACTIF SUR LE FRONT D'APRES : si je l'active maintenant, c'est pour qu'au coup d'H suivant on puisse incrémenter
                    enable_cpt_intern   <= '0';
                    
                    
                    --previous_state <= AJOUT_ZERO;
                    init_btn <= '0';
                    init_intern_cpt_1   <= '0';
                    init_intern_cpt_2   <= '0';
                    
                when SAVING =>
                    cpt_ram_grille_en   <= '1'; 
                    enable_cpt_intern   <= '0';
                    init_intern_cpt_2   <= '1';
                    
                    init_intern_cpt_1   <= '0';                                    
                    w_en_ram_grille     <= '0';
                    sel_dataw       <= "00";
                    sel_addr        <= '0';
                    sel_addw        <= '0';
                    cpt_ram_grille_init   <= '0';     
                    --previous_state <= SAVING; 
                    init_btn <= '0';    
                          
                when CALCUL =>  
                                        
                    bool_calc <= TRUE;
                                    
                    cpt_ram_grille_en   <= '1'; 
                    enable_cpt_intern   <= '1';
                    
                    
                    w_en_ram_grille     <= '0';
                    sel_dataw           <= "00";
                    sel_addw            <= '0';
                    sel_addr             <= '0';
                    cpt_ram_grille_init  <= '0';        

                    init_btn <= '0';
                    init_intern_cpt_1   <= '0';
                    init_intern_cpt_2   <= '0';
                    
                when ADD =>  
                                                                            
                    sel_dataw           <= "10";
                    sel_addw            <= '1';
                    w_en_ram_grille     <= '1';

                    cpt_ram_grille_en   <= '0'; 
                    enable_cpt_intern   <= '0';
                    
                    sel_addr             <= '0';
                    cpt_ram_grille_init  <= '0';        
                    previous_state  <= ADD;
                    init_btn <= '0';
                    init_intern_cpt_1   <= '0';
                    init_intern_cpt_2   <= '0';
                    
                    
                end case;
            
    end process cal_sig;

    cal_nx_state : process (rst, pr_state, addr_max_ram_grille, btn_haut, btn_bas, btn_droit, btn_gauche , bool_calc, zero, previous_state, cpt, cmp) --process transition
        begin
        
            case pr_state is
            
                when INIT =>    
                    nx_state <= INIT_GRILLE;
                    
                when INIT_GRILLE =>    
                -- on balance la grille de 0
                if (addr_max_ram_grille = '1') then
                    nx_state <= RESET_ADDR_GRILLE;
                end if;
                
                when RESET_ADDR_GRILLE =>    
                    nx_state <= RECHERCHE_ZERO;
                    
                when AJOUT_NOMBRE =>
                     nx_state <= EXPORT_GRILLE;

                    --pas de random, cpt qui balmlait les case et met un 0 qq part    
                when EXPORT_GRILLE => 
                    if addr_max_ram_grille = '1' then
                        nx_state <= WAITING;
                    end if;
                    
                    --activer un compteur qui ballaye toutes les cases, on reste dans l'état tant que pas addr max
                    --activer l'écriture sur la ram CPU qui fonctionnera en front descendant
                    --correctement orienter les mux 
                when WAITING =>
                    if (btn_haut OR btn_bas OR btn_droit OR btn_gauche) = '1' then
                        nx_state <= RECHERCHE_ZERO;
                    end if;
                    --tant que pas de bouton, on reste
                when RECHERCHE_ZERO =>
                    
                    if addr_max_ram_grille = '1' and bool_calc = FALSE then
                        nx_state <= SAVING;
                    
                    elsif (zero = '1' and bool_ajout_nombre = TRUE) then
                        nx_state <= AJOUT_NOMBRE;
                        
                    elsif (zero = '1' and cpt <= 3) then
                        nx_state <= DECALAGE;   
                        
                    else
                        nx_state <= RECHERCHE_ZERO;
                    end if;
                    
                when DECALAGE =>
                    nx_state <= AJOUT_ZERO;
                    
                when AJOUT_ZERO =>
                    if previous_state = DECALAGE then
                        nx_state <= RECHERCHE_ZERO;
                    elsif previous_state = ADD then
                        nx_state <= CALCUL;
                    else 
                        nx_state <= AJOUT_ZERO;
                    end if;
                        
                when SAVING =>
                    nx_state <= CALCUL;
                    
                when CALCUL =>  
                    if addr_max_ram_grille = '1' then
                        nx_state <= RESET_ADDR_GRILLE;
                        
                    elsif cpt >= 4 then
                        nx_state <= SAVING;
                        
                    elsif cmp = '1' then
                        nx_state <= ADD;
                    
                    else
                        nx_state <= CALCUL;
                    end if;
                    
                when ADD =>
                    nx_state <= AJOUT_ZERO;
                        
                end case;
            
    end process cal_nx_state;
end beh_machine_etats;

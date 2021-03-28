library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL ;


entity machine_etats is
  Port (    CLK, RST, CE            : in std_logic;
                       
            ind_i, ind_j            : in std_logic_vector (1 downto 0);       
            cmp, zero               : in std_logic;
            
            addr_max                : in std_logic;
            
            add_en                  : out std_logic;
            cpt_en, cpt_init        : out std_logic;
            w_en                    : out std_logic;
            
            sel_addr, sel_addw      : out std_logic;
            sel_dataw               : out std_logic_vector(1 downto 0));
end machine_etats;

architecture beh_machine_etats of machine_etats is

type Etat is (INIT, AJOUT_NOMBRE, EXPORT_GRILLE, WAITING, RECHERCHE_ZERO, DECALAGE, AJOUT_ZERO, SAVING, CALCUL);
signal pr_state, nx_state : Etat := Init;

signal cpt : integer range 1 to 5 := 0; 
signal enable_cpt_intern : STD_LOGIC;

signal bool_calc : boolean := FALSE;
                                               
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

    cal_nx_state : process (rst, pr_state) --process transition
        begin
        
            case pr_state is
            
                when INIT =>    
                   
                when AJOUT_NOMBRE =>
                        
                when EXPORT_GRILLE => 
                  
                when WAITING =>
                    
                when RECHERCHE_ZERO =>
                    if cpt < 4 then 
                        if zero = '1' then
                            cpt_en     <= '0';
                            enable_cpt_intern   <= '0';
                        else
                            cpt_en     <= '1';
                            enable_cpt_intern   <= '1';
                        end if;
                    else
                        cpt_en     <= '1';
                        enable_cpt_intern   <= '0';
                        cpt <= 1;
                    end if;
                    
                    if addr_max = '1' then
                        cpt_init       <= '1';
                    end if;
                    
                when DECALAGE =>
                    w_en    <= '1';
                    sel_dataw    <= "01";
                    sel_addr       <= '1';
                    
                    sel_addw               <= '0';
                    cpt_en     <= '0';
                    enable_cpt_intern   <= '0';
                    cpt_init       <= '0';
                    
                when AJOUT_ZERO =>
                    w_en    <= '1';
                    sel_dataw    <= "00";
                    
                    sel_addr               <= '0';
                    sel_addw               <= '0';
                    cpt_en     <= '1'; --FAIRE ATTENTION A CE QUE CE SOIT ACTIF SUR LE FRONT D'APRES : si je l'active maintenant, c'est pour qu'au coup d'H suivant on puisse incrémenter
                    enable_cpt_intern   <= '1';
                    
                when SAVING =>
                    cpt_en     <= '1'; 
                    enable_cpt_intern   <= '0';
                    cpt                 <= 2;    
                                    
                    w_en            <= '0';
                    sel_dataw            <= "00";
                    sel_addr               <= '0';
                    sel_addw               <= '0';
                    cpt_init       <= '0';     
                               
                when CALCUL =>  
                    bool_calc <= TRUE;
                    
                    if cmp = '1' then
                        w_en            <= '1';
                    else
                        w_en            <= '0';
                    end if;   
                    
                    if addr_max = '1' then
                        cpt_init       <= '1';
                    end if;
                
                    sel_dataw            <= "10";
                    sel_addw               <= '0';
                    cpt_en     <= '1'; 
                    enable_cpt_intern   <= '1';
                                    
                    sel_addr               <= '0';
                    cpt_init       <= '0';        
                                      
                end case;
            
    end process cal_nx_state;

    cal_sig : process (rst, pr_state) --process signaux
        begin
        
            case pr_state is
            
                when INIT =>    
                   
                when AJOUT_NOMBRE =>
                        
                when EXPORT_GRILLE => 
                  
                when WAITING =>
                
                when RECHERCHE_ZERO =>
                  
                when DECALAGE =>
                  
                when AJOUT_ZERO =>
                
                when SAVING =>
                
                when CALCUL =>  
                
                end case;
            
    end process cal_sig;

end beh_machine_etats;

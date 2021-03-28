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
                                                    
begin

end beh_machine_etats;

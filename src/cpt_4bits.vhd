library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE . NUMERIC_STD.ALL ;

entity cpt_4bits is
    Port ( clk, rst, CE     :   in  STD_LOGIC;
           cpt_enable       :   in  STD_LOGIC;
           cpt_init         :   in  STD_LOGIC;
           cpt_value        :   out STD_LOGIC_VECTOR (3 downto 0));
end cpt_4bits;

architecture beh_cpt_4bits of cpt_4bits is

    signal cmp : unsigned (3 downto 0) := "0000";
    
    begin
    
    cmpsync : process (clk , rst)
        begin
        
        if ( rst = '1') then 
            cmp <= "0000";
            
        elsif ( clk = '1' and clk ' event ) then
            if (CE = '1') then
                if (cpt_init = '1') then
                    cmp <= "0000";
                elsif (cpt_enable = '1') then
                    cmp <= cmp + 1;                  
                else 
                    cmp <= cmp;
                end if;
             end if;     
        end if;
    end process cmpsync;

cpt_value <= std_logic_vector(cmp(3 DOWNTO 0));

end beh_cpt_4bits;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.02.2021 08:59:20
-- Design Name: 
-- Module Name: compteur - RTL
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE . NUMERIC_STD.ALL ;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity cpt_addr_RAM is
    Port ( clk, rst, CE :   in      STD_LOGIC;
           enable       :   in      STD_LOGIC;
           init         :   in      STD_LOGIC;
           data_Out     :   out     STD_LOGIC_VECTOR (10 downto 0)
           );
end cpt_addr_RAM;

architecture RTL of cpt_addr_RAM is

    signal cmp : unsigned (10 downto 0) := "00000000000";
    
    begin
    
    cmpsync : process (clk , rst)
        begin
        
        if ( rst = '0') then
            cmp        <= "00000000000";
        elsif ( clk = '1' and clk ' event ) then
            if (CE = '1') then
                if (init = '1') then
                    cmp <= "00000000000";
                elsif (enable = '1') then
                    if (cmp = "11000111111") then
                        cmp <= "00000000000";
                    else cmp <= cmp + 1; end if;
                else 
                    cmp <= cmp;
                end if;
             end if;     
        end if;
        

    end process cmpsync;

data_out <= std_logic_vector(cmp);

end RTL;

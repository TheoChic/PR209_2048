----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2021 19:43:16
-- Design Name: 
-- Module Name: cpt_export_grille - beh_cpt_export_grille
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_div is
    Port ( clk, rst     :   in  STD_LOGIC;
           CE_graph     :   out STD_LOGIC);
end clk_div;

architecture beh_clk_div of clk_div is

signal cpt         : unsigned (9 downto 0):= "000000000000";

begin

    process (clk , rst)
        begin
        
            if ( rst = '0') then
                cpt    <= "000000000000";
                        
            elsif ( clk = '1' and clk ' event ) then
                 if (cpt = "1111101000") then
                    cpt <= "000000000000";
                    CE_graph <= '1';
                 else
                    cpt <= cpt + 1;
                    CE_graph <= '0';
                 end if;
                    
            end if; 
     
    end process;
    
end beh_clk_div;

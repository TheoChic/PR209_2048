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

entity cpt_export_grille is
    Port ( clk, rst, CE :   in  STD_LOGIC;
           cpt_en       :   in  STD_LOGIC;
           init         :   in  STD_LOGIC;
           addr_max     :   out STD_LOGIC;
           addr         :   out STD_LOGIC_VECTOR (3 downto 0));
end cpt_export_grille;

architecture beh_cpt_export_grille of cpt_export_grille is

signal addr_int         : unsigned (3 downto 0);

begin

    cptsync : process (clk , rst)
        
        begin
        
            if ( rst = '0') then
                addr_int    <= "0000";
                        
            elsif ( clk = '1' and clk ' event ) then
                
                if (CE = '1') then
                    if init = '1' then
                        addr_int    <= "0000";
                    elsif (cpt_en = '1') then
                        addr_int <= addr_int + 1;
                    end if;
                    
                end if; 
                
            end if;    
                
    end process cptsync;
    
    with addr_int select
        addr_max <= '1' when "1111" ,
                    '0' when others;  
    
    addr     <= std_logic_vector(addr_int); 

end beh_cpt_export_grille;

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
    Port (  clk, rst     :   in  STD_LOGIC;
            CE_VGA       :   out STD_LOGIC;
            CE_addr      :   out STD_LOGIC;
            CE_process   :   out STD_LOGIC);
end clk_div;

architecture beh_clk_div of clk_div is

signal cpt_vga      : unsigned (10 downto 0):= (others => '0'); 
signal cpt_addr     : unsigned (10 downto 0):= (others => '0'); 
signal cpt_process  : unsigned (3 downto 0):= (others => '0'); 
begin

    process (clk , rst)
        begin
        
            if ( rst = '0') then
                cpt_vga    <= (others => '0');
                cpt_addr   <= (others => '0');

            elsif ( clk = '1' and clk ' event ) then
                 if (cpt_vga = "0000000001") then -- 1111101000 1000 hz
                    cpt_vga <= (others => '0');
                    CE_VGA <= '1';
                 else
                    cpt_vga <= cpt_vga + 1;
                    CE_vga <= '0';
                 end if;
                 ----------------CE ADDR mem partagee to conv_grid
                 if cpt_addr = "11111010000" then   -- 101111101011110000100f = 64Hz => 4 grille / s
                    cpt_addr <= (others => '0');
                    CE_addr <= '1';
                 else
                    cpt_addr <= cpt_addr + 1;
                    CE_addr <= '0';
                 end if;  
                 
                 ----------------CE process----------------------
                 if cpt_process = "0" then  --20 MHz
                    cpt_process <= (others => '0');
                    CE_process <= '1';
                 else
                    cpt_process <= cpt_process + 1;
                    CE_process <= '0';
                 end if;  
            end if; 
     
    end process;
    
end beh_clk_div;

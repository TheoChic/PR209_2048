----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 08:04:03
-- Design Name: 
-- Module Name: RAM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_20x20_16 is
 
    Port ( clk      : in    STD_LOGIC;
           CE       : in    STD_LOGIC;
           enable   : in    STD_LOGIC;
           adr      : in    STD_LOGIC_VECTOR(8 downto 0);
           data_out : out   STD_LOGIC_VECTOR(7 downto 0));
end RAM_20x20_16;

architecture Behavioral of RAM_20x20_16 is
    TYPE RAM IS ARRAY (0 TO 399) OF STD_LOGIC_VECTOR(7 downto 0);

    SIGNAL mem      : RAM := (X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FA",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FE",X"FA",X"FA",X"FA",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FA",X"F1",X"F0",X"FA",X"FF",X"FF",X"FF",X"FF",X"F6",X"F0",X"F0",X"F0",X"F0",X"FA",X"FF",X"FF",X"FF",X"FF",X"FF",X"F5",X"F0",X"F5",X"F0",X"FA",X"FF",X"FF",X"FF",X"FA",X"F0",X"F5",X"FF",X"FF",X"FA",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"F5",X"FE",X"FA",X"F0",X"FA",X"FF",X"FF",X"FF",X"F5",X"F5",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FA",X"F0",X"FA",X"FF",X"FF",X"FF",X"F0",X"F5",X"FA",X"FA",X"FA",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FA",X"F0",X"FA",X"FF",X"FF",X"FF",X"F0",X"F0",X"F0",X"F0",X"F0",X"F5",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FA",X"F0",X"FA",X"FF",X"FF",X"FE",X"F0",X"F5",X"FE",X"FF",X"FA",X"F0",X"F5",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FA",X"F0",X"FA",X"FF",X"FF",X"FF",X"F0",X"F6",X"FF",X"FF",X"FF",X"F1",X"F5",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FA",X"F0",X"FA",X"FF",X"FF",X"FF",X"F1",X"F5",X"FF",X"FF",X"FF",X"F0",X"F5",X"FF",X"FF",X"FF",X"FF",X"FF",X"FE",X"FA",X"FA",X"F0",X"FA",X"FA",X"FF",X"FF",X"F5",X"F0",X"FA",X"FF",X"F5",X"F0",X"FA",X"FF",X"FF",X"FF",X"FF",X"FF",X"F5",X"F0",X"F0",X"F0",X"F0",X"F0",X"FA",X"FF",X"FF",X"F5",X"F0",X"F0",X"F0",X"FA",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FE",X"FE",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF");
    begin
    
    mem_process: process(clk)
    begin
       if (clk'event and clk = '0') then
            if (CE = '1') then
                if (enable = '1') then
                    data_out <= mem(TO_INTEGER(UNSIGNED(adr)));
                end if;                
            end if;
        end if;   
    end process;     
end Behavioral;

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

entity RAM_double_acces is
 
    Port ( clk              : in    STD_LOGIC;
           CE               : in    STD_LOGIC;
           enable_writing   : in    STD_LOGIC;
           adr_out          : in    STD_LOGIC_VECTOR(16 downto 0);
           adr_in           : in    STD_LOGIC_VECTOR(16 downto 0);
           data_in          : in    STD_LOGIC_VECTOR(7 downto 0);
           data_out         : out   STD_LOGIC_VECTOR(7 downto 0));
end RAM_double_acces;

architecture Behavioral of RAM_double_acces is
    TYPE RAM IS ARRAY (0 TO 76799) OF STD_LOGIC_VECTOR(7 downto 0);

    SIGNAL mem      : RAM := (others => X"F5");
    begin
    
    mem_process: process(clk)
    begin
       if (clk'event and clk = '1') then
            if (CE = '1') then
                if (enable_writing = '1') then
                    mem(TO_INTEGER(UNSIGNED(adr_in))) <= data_in;
                end if;                   
                data_out <= mem(TO_INTEGER(UNSIGNED(adr_out)));               
            end if;
        end if;
       
    end process;     
end Behavioral;

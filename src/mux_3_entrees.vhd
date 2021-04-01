----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2021 12:38:05
-- Design Name: 
-- Module Name: mux_3_entrees - beh_mux_3_entrees
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_3_entrees is
    Port ( e0, e1, e2, e3   : in STD_LOGIC_VECTOR (11 downto 0);
           sel              : in STD_LOGIC_VECTOR (1 downto 0);
           y                : out STD_LOGIC_VECTOR (11 downto 0));
end mux_3_entrees;

architecture beh_mux_3_entrees of mux_3_entrees is

begin
    with sel select
        y <=    e0 when "00",
                e1 when "01",
                e2 when "10",
                e3 when others;

end beh_mux_3_entrees;

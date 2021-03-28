----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2021 16:39:42
-- Design Name: 
-- Module Name: mux_4_entrees - beh_mux_4_entrees
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

entity mux_4_entrees is
    Port ( e0, e1, e2, e3   : in STD_LOGIC_VECTOR (1 downto 0);
           sel              : in STD_LOGIC_VECTOR (3 downto 0);
           y                : out STD_LOGIC_VECTOR (1 downto 0));
end mux_4_entrees;

architecture beh_mux_4_entrees of mux_4_entrees is

begin
    with sel select
        y <=    e0 when "0001",
                e1 when "0010",
                e2 when "0100",
                e3 when others;        

end beh_mux_4_entrees;

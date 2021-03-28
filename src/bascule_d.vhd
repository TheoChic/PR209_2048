----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2021 12:38:05
-- Design Name: 
-- Module Name: bascule_d - beh_bascule_d
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
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bascule_d is
    Port ( clk : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (11 downto 0);
           q : out STD_LOGIC_VECTOR (11 downto 0));
end bascule_d;

architecture beh_bascule_d of bascule_d is

begin

    process (clk)
        begin
            if rising_edge (clk) then
                q <= d;
            end if;
    end process;

end beh_bascule_d;

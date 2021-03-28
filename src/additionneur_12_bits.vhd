----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2021 19:36:16
-- Design Name: 
-- Module Name: additionneur_12_bits - beh_additionneur_12_bits
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

entity additionneur_12_bits is
    Port ( c1, c2   : in STD_LOGIC_VECTOR (11 downto 0);
           en_add   : in STD_LOGIC;
           add      : out STD_LOGIC_VECTOR (11 downto 0));
end additionneur_12_bits;

architecture beh_additionneur_12_bits of additionneur_12_bits is

signal sum : unsigned (11 downto 0);

begin

    with en_add select
        sum <= resize(unsigned(c1), 12) + resize(unsigned(c2), 12) when '1',
               "000000000000" when others;
   
    add <= std_logic_vector(sum); 
         
end beh_additionneur_12_bits;
